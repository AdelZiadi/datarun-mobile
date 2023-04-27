import 'package:d2_remote/shared/models/request_progress.model.dart';
import 'package:dio/dio.dart';
import '../../../commons/helpers/result.dart';
import '../../../core/arch/call/d2_progress.dart';
import '../mp_services/d2_request_progress.dart';
import 'sync_result.dart';

abstract class SyncPresenter {
  Future<void> syncAndDownloadEvents({Dio? dioTestClient}); // throws Exception;

  Future<void> syncAndDownloadTeis({Dio? dioTestClient}); // throws Exception;

  Future<void> syncMetadata({Dio? dioTestClient}); // throws Exception;

  Future<void> syncAndDownloadDataValues(
      {Dio? dioTestClient}); // throws Exception;

  Future<void> syncReservedValues({Dio? dioTestClient});

  Future<SyncResult> checkSyncStatus();

  /// TrackerD2Progress
  Future<D2Progress> syncGranularEvent(String eventUid, {Dio? dioTestClient});

  /// ListenableWorker.Result
  Future<Result<String>> syncGranularProgram(String programUid,
      {Dio? dioTestClient});

  Future<Result<String>> syncGranularActivity(String activityUid,
      {Dio? dioTestClient});

  /// ListenableWorker.Result
  Future<Result<String>> syncGranularTei(
      String? teiUid, String? activityUid, String? orgUnit,
      {Dio? dioTestClient});

  // /// ListenableWorker.Result
  // Future<Result<String>> blockSyncGranularEvent(String eventUid,
  //     {Dio? dioTestClient});

  /// ListenableWorker.Result
  Future<Result<String>> syncGranularDataSet(String dataSetUid,
      {Dio? dioTestClient});

  // /// Observable
  // Future<D2Progress> syncGranularProgram(String uid, {Dio? dioTestClient});

  // /// Observable
  // /// TrackerD2Progress
  // Future<D2Progress> syncGranularTEI(String uid, {Dio? dioTestClient});

  // /// Observable
  // Future<D2Progress> syncGranularDataSet(String uid, {Dio? dioTestClient});

  /// Observable
  Future<Result<String>> syncGranularDataValues(
      String? activityUid, String? orgUnit, String? period,
      {Dio? dioTestClient});

  /// Observable
  Future<D2Progress> syncGranularDataSetDataComplete(
      String dataSetUid,
      String activityUid,
      String orgUnit,
      String attributeOptionCombo,
      String period,
      {Dio? dioTestClient});

  /// Observable
  Future<D2Progress> syncGranularDataSetComplete(String dataSetUid,
      {Dio? dioTestClient});

  Future<SyncResult> checkSyncEventStatus(String uid);

  Future<SyncResult> checkSyncTEIStatus(String uid);

  Future<bool> checkSyncDataValueStatus(
      String orgUnit, String attributeOptionCombo, String period);

  Future<bool> checkSyncProgramStatus(String uid);

  Future<bool> checkSyncDataSetStatus(String uid);

  // List<TrackerImportConflict> messageTrackerImportConflict(String uid);

  void startPeriodicDataWork();

  void startPeriodicMetaWork();

  Future<void> downloadResources({Dio? dioTestClient});

  /// ListenableWorker.Result
  Future<Result<String>> syncGranularDataSetValues(String dataSetUid,
      String activityUid, String orgUnitUid, String? periodId,
      {Dio? dioTestClient});

  void logTimeToFinish(int millisToFinish, String eventName);

  void updateProyectAnalytics();

  Future<void> initSyncControllerMap();

  void finishSync();

  void setNetworkUnavailable();
}
