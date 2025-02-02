import 'package:mass_pro/sdk/core/mp/enrollment/enrollment_status.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_remote/modules/data/tracker/models/geometry.dart';
import 'package:d2_remote/shared/utilities/merge_mode.util.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';

import 'package:d2_remote/core/datarun/utilities/date_utils.dart';
import 'package:mass_pro/core/event/event_status.dart';

class EventObjectRepository {
  EventObjectRepository(this.uid);

  String uid;

  Future<void> updateObject(Event enrollment) async {
    D2Remote.trackerModule.enrollment.mergeMode = MergeMode.Merge;
    await D2Remote.trackerModule.enrollment
        .setData(enrollment)
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));
    D2Remote.trackerModule.enrollment.mergeMode = MergeMode.Replace;
  }

  ///  throws D2Error
  Future<void> setOrganisationUnitUid(String organisationUnitUid) async {
    return updateObject((await updateBuilder())..orgUnit = organisationUnitUid);
  }

  ///  throws D2Error
  Future<void> setEventDate(DateTime? enrollmentDate) async {
    final String? date = enrollmentDate?.toIso8601String().split('.')[0];
    return updateObject((await updateBuilder())..eventDate = date);
  }

  ///  throws D2Error
  Future<void> setStatus(EventStatus eventStatus) async {
    final String? completedDate = eventStatus == EnrollmentStatus.COMPLETED
        ? DateUtils.databaseDateFormat().format(DateTime.now())
        : null;

    return updateObject((await updateBuilder())
      ..status = eventStatus.name
      ..completedDate = completedDate);
  }

  ///  throws D2Error
  Future<void> setCompletedDate(DateTime completedDate) async {
    // final date = completedDate.toIso8601String().split('.')[0];
    final String date = DateUtils.databaseDateFormat().format(completedDate);
    return updateObject((await updateBuilder())..completedDate = date);
  }

  ///  throws D2Error
  Future<void> setDueDate(DateTime dueDate) async {
    final String date = DateUtils.databaseDateFormat().format(dueDate);
    return updateObject((await updateBuilder())..dueDate = date);
  }

  ///  throws D2Error
  Future<void> setGeometry(Geometry? geometry) async {
    // GeometryHelper.validateGeometry(geometry);

    return updateObject((await updateBuilder())..geometry = geometry);
  }

  ///  throws D2Error
  // Future<void> setAssignedUser(String assignedUser) async {
  //   return await updateObject(
  //       (await updateBuilder())..assignedUser = assignedUser);
  // }

  ///  throws D2Error
  // Future<void> setFollowUp(bool followUp) async {
  // return updateObject((await updateBuilder())..followUp = followUp);
  // }

  Future<Event> updateBuilder() async {
    final Event event =
        (await D2Remote.trackerModule.event.byId(uid).getOne())!;
    // final String updateDate = DateUtils.databaseDateFormat().format(DateTime.now());
    final String updateDate =
        DateUtils.databaseDateFormat().format(DateTime.now());

    // bool? state = enrollment.synced;
    // state = state == State.TO_POST ? state : State.TO_UPDATE;

    event.lastModifiedDate = updateDate;
    // enrollment.lastUpdatedAtClient = updateDate;

    event.synced = false;
    event.dirty = true;

    return event;
  }

  Future<void> deleteObject(Event enrollment) async {
    await D2Remote.trackerModule.enrollment.byId(uid).delete();
  }

  Future<Event?> getEvent() async {
    return D2Remote.trackerModule.event.byId(uid).getOne();
  }
}
