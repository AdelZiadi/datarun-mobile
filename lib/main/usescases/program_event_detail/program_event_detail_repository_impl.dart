import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_remote/modules/metadata/program/entities/program_stage.entity.dart';

import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';

import 'package:d2_remote/modules/activity_management/activity/entities/activity.entity.dart';

import 'package:d2_remote/core/common/feature_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../commons/data/event_view_model.dart';
import 'di/program_event_detail_providers.dart';
import 'program_event_mapper.dart';

import '../../../commons/data/program_event_view_model.dart';
import '../../../commons/extensions/feature_type_extension.dart';
import '../../../commons/extensions/standard_extensions.dart';
import 'program_event_detail_repository.dart';
import 'program_event_map_data.dart';

class ProgramEventDetailRepositoryImpl implements ProgramEventDetailRepository {
  ProgramEventDetailRepositoryImpl(this.programUid, this.ref, this.mapper);
  ProgramEventDetailRepositoryRef ref;
  final String programUid;
  final ProgramEventMapper mapper;

  @override
  Future<List<EventModel>> programEvents() async {
    final List<Event> events = await D2Remote.trackerModule.event.get();
    final List<EventModel> eventsModels = [];
    Future.forEach(
        events,
        (Event it) async =>
            eventsModels.add(await mapper.eventToEventViewModel(it)));
    return eventsModels;
  }

  @override
  Future<ProgramEventMapData> filteredEventsForMap() {
    // TODO: implement filteredEventsForMap
    throw UnimplementedError();
  }

  @override
  Future<ProgramEventViewModel> getInfoForEvent(String eventUid) async {
    return (await D2Remote.trackerModule.event
            .byId(eventUid)
            .withDataValues()
            .getOne())!
        .let(mapper.eventToProgramEvent);
  }

  @override
  Future<FeatureType> featureType() async {
    return (await D2Remote.programModule.programStage
            .byProgram(programUid)
            .getOne())!
        .let((ProgramStage stage) {
      if (stage.featureType != null)
        return stage.featureType.toFeatureType!;
      else
        return FeatureType.NONE;
    });
  }

  @override
  Future<Activity> getActivity(String selectedActivity) async {
    return (await D2Remote.activityModule.activity
        .byId(selectedActivity)
        .getOne())!;
  }

  @override
  Future<ProgramStage?> programStage() async {
    return D2Remote.programModule.programStage.byProgram(programUid).getOne();
  }

  @override
  Future<Program> program() async {
    return (await D2Remote.programModule.program.byId(programUid).getOne())!;
  }

  @override
  Future<bool> getAccessDataWrite() {
    // TODO: implement getAccessDataWrite
    return Future.value(true);
  }

  @override
  Future<bool> hasAccessToAllCatOptions() {
    // TODO: implement hasAccessToAllCatOptions
    throw UnimplementedError();
  }

  @override
  Future<bool> programHasAnalytics() {
    // TODO: implement programHasAnalytics
    throw UnimplementedError();
  }

  @override
  Future<bool> programHasCoordinates() {
    // TODO: implement programHasCoordinates
    throw UnimplementedError();
  }
}
