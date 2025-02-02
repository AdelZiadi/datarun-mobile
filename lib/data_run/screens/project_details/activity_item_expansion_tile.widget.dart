import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:mass_pro/commons/constants.dart';
import 'package:mass_pro/core/common/state.dart' as item_state;
import 'package:mass_pro/data_run/screens/data_submission_screen/data_submission_screen.widget.dart';
import 'package:mass_pro/data_run/screens/entities_list_screen/entities_list_screen.widget.dart';
import 'package:mass_pro/data_run/screens/project_details/entity_creation_dialog/entity_creation_dialog.widget.dart';
import 'package:mass_pro/data_run/screens/project_details/form_tiles/form_tiles.widget.dart';
import 'package:mass_pro/data_run/screens/project_details/project_detail_item.model.dart';
import 'package:mass_pro/data_run/screens/project_details/project_detail_items_models_notifier.dart';
import 'package:mass_pro/generated/l10n.dart';
import 'package:mass_pro/main/usescases/bundle/bundle.dart';
import 'package:mass_pro/utils/mass_utils/utils.dart';

/// EventViewHolder
class ActivityItemsExpansionTiles extends ConsumerWidget {
  const ActivityItemsExpansionTiles({
    super.key,
    this.onGranularSyncClick,
    this.onDescriptionClick,
  });

  final void Function(ProjectDetailItemModel? projectItemModel)?
      onGranularSyncClick;
  final void Function(ProjectDetailItemModel? projectItemModel)?
      onDescriptionClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProjectDetailItemModel projectDetailItemModel =
        ref.watch(projectDetailItemModelProvider);

    final Color? cardColor = projectDetailItemModel.activeFormCount > 0
        ? Colors.white
        : convertHexStringToColor('#FAFAFA');

    /// Get the icon based on Synced/synced status
    final Widget statusActionButton =
        when(projectDetailItemModel.syncablesState, {
      item_state.SyncableEntityState.uploadableStates: () => IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          icon: const Icon(Icons.cloud_sync),
          onPressed: () => onGranularSyncClick?.call(projectDetailItemModel)),
      item_state.SyncableEntityState.ERROR: () =>
          const Icon(Icons.warning_amber, color: Colors.red),
    }).orElse(() => Icon(Icons.check, color: Colors.green[300]));

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.grey[200],
        initiallyExpanded: projectDetailItemModel.valueListIsOpen,
        onExpansionChanged: (bool isExpanded) {
          ref
              .read(projectDetailItemsModelsNotifierProvider.notifier)
              .toggleExpansion(projectDetailItemModel);
        },
        leading: const Icon(Icons.event_note_sharp),
        trailing: statusActionButton,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectDetailItemModel.activityName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    S.of(context).form(projectDetailItemModel.activeFormCount),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            // statusActionButton,
          ],
        ),
        subtitle: projectDetailItemModel.valueListIsOpen
            ? Text(
                S.of(context).viewAvailableForms,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            : null,
        backgroundColor: cardColor,
        children: projectDetailItemModel.activeFormCount > 0
            ? [
                FormsTiles(
                  onList: (model) async {
                    await navigateToEntitiesList(model);
                    ref.invalidate(projectDetailItemModelProvider);
                  },
                  onAdd: (FormListItemModel? formModel) =>
                      _showAddEntityDialog(context, ref, formModel),
                )
              ]
            : [ListTile(title: Text(S.of(context).noFormsAvailable))],
      ),
    );
  }

  Future<void> _showAddEntityDialog(
      BuildContext context, WidgetRef ref, FormListItemModel? formModel) async {
    // Check if the context is still mounted
    if (!context.mounted) {
      return;
    }

    final result = await showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return EntityCreationDialog(formModel: formModel!);
        });
    // go to form
    if (result != null) {
      await _goToDataEntryForm(result as String, formModel!);
      ref.invalidate(projectDetailItemModelProvider);
    } else {
      // Handle cancellation or failure
    }
  }

  Future<void> _goToDataEntryForm(
      String createdEntityUid, FormListItemModel formModel) async {
    Bundle bundle = Bundle();
    bundle = bundle.putString(ACTIVITY_UID, formModel.activity);
    bundle = bundle.putString(TEAM_UID, formModel.team);
    bundle = bundle.putString(FORM_UID, formModel.form);
    bundle = bundle.putString(FORM_CODE, formModel.formCode);
    bundle = bundle.putString(SYNCABLE_UID, createdEntityUid);

    /// navigate to the form screen to fill the rest of the fields
    await Get.to(const DataSubmissionScreen(), arguments: bundle);
  }

  Future<void> navigateToEntitiesList(FormListItemModel? formModel) async {
    Bundle bundle = Bundle();
    bundle = bundle.putString(ACTIVITY_UID, formModel!.activity);
    bundle = bundle.putString(TEAM_UID, formModel.team);
    bundle = bundle.putString(FORM_UID, formModel.form);
    bundle = bundle.putString(FORM_CODE, formModel.formCode);

    await Get.to(EntitiesListScreen(formModel: formModel), arguments: bundle);
  }
}
