import 'package:d2_remote/d2_remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../commons/extensions/standard_extensions.dart';
import '../../../commons/prefs/preference.dart';
import '../../../commons/prefs/preference_provider.dart';
import '../../data/service/work_manager/nmc_worker/work_info.dart';
import '../../data/service/work_manager/work_manager_controller.dart';
import '../../data/service/work_manager/work_manager_controller_impl.dart';
import '../events_without_registration/event_initial/di/event_initial_module.dart';
import 'sync_view.dart';
part 'sync_presenter.g.dart';

@riverpod
SyncPresenter syncScreenPresenter(SyncScreenPresenterRef ref, SyncView view) {
  return SyncPresenter(view, ref.read(preferencesInstanceProvider),
      ref.read(workManagerControllerProvider));
}

class SyncPresenter {
  SyncPresenter(this.view, this.preferences, this.workManagerController) {
    workManagerController.syncMetaDataForWorker(META_NOW, INITIAL_SYNC);
  }

  final SyncView view;
  // final UserManager? userManager;
  final WorkManagerController workManagerController;
  final PreferenceProvider preferences;

  // LiveData<List<WorkInfo>> observeSyncProcess() {
  //       return workManagerController.getWorkInfosForUniqueWorkLiveData(Constants.INITIAL_SYNC);
  //   }

  void handleSyncInfo(/* List<WorkInfo> workInfoList */) {
    // workInfoList.forEach { workInfo ->
    //     if (workInfo.tags.contains(Constants.META_NOW)) {
    //         handleMetaState(workInfo.state, workInfo.outputData.getString(METADATA_MESSAGE))
    //     }
    // }
  }

  void handleMetaState(WorkInfoState state, String? message) {
    when(state, {
      WorkInfoState.RUNNING: () => view.setMetadataSyncStarted(),
      WorkInfoState.SUCCEEDED: () => view.setMetadataSyncSucceed(),
      WorkInfoState.FAILED: () => view.showMetadataFailedMessage(message),
    });
  }

  void onMetadataSyncSuccess() {
    preferences.setValue(INITIAL_METADATA_SYNC_DONE, true);
    // userManager?.let { userManager ->
    //     disposable.add(
    //         userManager.theme.doOnSuccess { flagAndTheme ->
    //             preferences.setValue(Preference.FLAG, flagAndTheme.first)
    //             preferences.setValue(Preference.THEME, flagAndTheme.second)
    //         }
    //             .subscribeOn(schedulerProvider.io())
    //             .observeOn(schedulerProvider.ui())
    //             .subscribe(
    //                 { (first, second) ->
    //                     view.setFlag(first)
    //                     view.setServerTheme(second)
    view.goToMain();
    //             },
    //             { t: Throwable? ->
    //                 Timber.e(t)
    //             }
    //         )
    // )
  }

  Future<void> onLogout() async {
    await D2Remote.logOut();
    // userManager?.let { userManager ->
    //     disposable.add(
    //         userManager.logout()
    //             .subscribeOn(schedulerProvider.io())
    //             .observeOn(schedulerProvider.ui())
    //             .subscribe(
    //                 {
    view.goToLogin();
    //                   }
    //             ) { t: Throwable? ->
    //                 Timber.e(t)
    //             }
    //     )
    // }
  }
}