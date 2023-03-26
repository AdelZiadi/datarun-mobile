import 'package:d2_remote/core/maintenance/d2_error.dart';
import 'package:d2_remote/core/mp/period/period_type.dart';
import 'package:d2_remote/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dartx/dartx_io.dart';
import '../../commons/constants.dart';
import '../../commons/extensions/string_extension.dart';
import '../../commons/period/period_extensions.dart';
import 'enrollment_event_generator_repository.dart';

class EnrollmentEventGenerator {
  const EnrollmentEventGenerator(this._generatorRepository);

  final EnrollmentEventGeneratorRepository _generatorRepository;

  Future<Pair<String, String?>> generateEnrollmentEvents(
      String enrollmentUid) async {
    final Enrollment enrollment =
        await _generatorRepository.enrollment(enrollmentUid);
    _autogeneratedEvents(enrollment);
    return _firstStageToOpen(enrollment);
  }

  Future<void> _autogeneratedEvents(Enrollment enrollment) async {
    final List<ProgramStage> autogeneratedEvents = await _generatorRepository
        .enrollmentAutogeneratedEvents(enrollment.id!, enrollment.program);
    for (final ProgramStage programStage in autogeneratedEvents) {
      await _generateEvent(enrollment, programStage, () {
        switch (programStage.reportDateToUse) {
          case Constants.ENROLLMENT_DATE:
            return enrollment.enrollmentDate.toDate();
          case Constants.INCIDENT_DATE:
            return enrollment.incidentDate.toDate();
          default:
            return null;
        }
      });
    }
  }

  Future<Pair<String, String?>> _firstStageToOpen(Enrollment enrollment) async {
    final Program program =
        await _generatorRepository.enrollmentProgram(enrollment.program);
    ProgramStage? stageToOpen;
    if (program.useFirstStageDuringRegistration ?? false) {
      stageToOpen =
          await _generatorRepository.firstStagesInProgram(enrollment.program);
    } else {
      stageToOpen = await _generatorRepository
          .firstOpenAfterEnrollmentStage(enrollment.program);
    }
    return stageToOpen != null
        ? await _checkIfEventExist(enrollment, stageToOpen)
        : Pair<String, String?>(enrollment.id!, null);
  }

  Future<Pair<String, String>> _checkIfEventExist(
      Enrollment enrollment, ProgramStage programStage) async {
    if (!(await _generatorRepository.eventExistInEnrollment(
        enrollment.id!, programStage.id!))) {
      _generateEvent(enrollment, programStage, () {
        final bool generateByEnrollmentDate =
            programStage.generatedByEnrollmentDate ?? false;
        if (!generateByEnrollmentDate && enrollment.incidentDate != null) {
          enrollment.incidentDate.toDate();
        } else {
          enrollment.enrollmentDate.toDate();
        }
      });
    }
    final String eventUidToOpen = await _generatorRepository
        .eventUidInEnrollment(enrollment.id!, programStage.id!);
    return Pair(enrollment.id!, eventUidToOpen);
  }

  Future<void> _generateEvent(Enrollment enrollment, ProgramStage programStage,
      DateTime? Function() dateToUse) async {
    try {
      final eventUid = await _generatorRepository.addEvent(
          enrollment.id!,
          enrollment.program,
          programStage.id!,
          enrollment.orgUnit,
          enrollment.activity);

      final bool hideDueDate = programStage.hideDueDate;
      final PeriodType? periodType = programStage.periodType?.toPeriodType;
      final int minDaysFromStart = programStage.minDaysFromStart ?? 0;

      final DateTime now = DateTime.now();
      final DateTime date = dateToUse() ?? now;

      DateTime eventDate = DateTime(date.year, date.month, date.day);

      if (periodType != null) {
        eventDate = await _generatorRepository.periodStartingDate(
            periodType, eventDate);
      }

      final bool isSchedule = eventDate.isAfter(now) && !hideDueDate;
      await _generatorRepository.setEventDate(eventUid, isSchedule, eventDate);
    } on D2Error catch (d2Error) {
      print(d2Error);
    }
  }
}
