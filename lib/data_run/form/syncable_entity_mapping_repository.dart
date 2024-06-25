import 'dart:async';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/dynamic_form.entity.dart';
import 'package:d2_remote/modules/datarun_shared/entities/syncable.entity.dart';
import 'package:d2_remote/modules/datarun_shared/queries/syncable.query.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/dynamic_form_field.entity.dart';
import 'package:d2_remote/shared/utilities/merge_mode.util.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:mass_pro/commons/date/date_utils.dart' as sdk;
import 'package:mass_pro/commons/extensions/string_extension.dart';
import 'package:mass_pro/commons/extensions/value_extensions.dart';
import 'package:mass_pro/commons/extensions/value_type_rendering_extension.dart';
import 'package:mass_pro/commons/helpers/iterable.dart';
import 'package:mass_pro/data_run/form/form_input_field.model.dart';
import 'package:mass_pro/form/model/store_result.dart';
import 'package:mass_pro/form/model/value_store_result.dart';
import 'package:mass_pro/sdk/core/common/value_type.dart';

class SyncableEntityMappingRepository {
  final String _entityUid;
  final SyncableQuery syncableQuery;

  SyncableEntityMappingRepository({
    required this.syncableQuery,
    required String entityUid,
  }) : _entityUid = entityUid;

  Future<IList<FormFieldModel>> list() async {
    final SyncableEntity syncableEntity =
        (await syncableQuery.byId(_entityUid).getOne())!;
    final DynamicForm form = (await D2Remote.formModule.form
        .where(attribute: 'activity', value: syncableEntity.activity)
        .getOne())!;
    final entityMap = IMapConst(syncableEntity.toJson());

    IList<FormFieldModel> fieldsModels = IList([]);
    for (final field in form.fields ?? []) {
      fieldsModels = fieldsModels
          .add(mapToModel(field: field, value: entityMap.get(field.name)));
    }
    return fieldsModels;
  }

  FormFieldModel mapToModel({
    required DynamicFormField field,
    dynamic value,
  }) {
    return FormFieldModel(
      key: field.name,
      isFocused: false,
      isEditable: true,
      isMandatory: field.required,
      label: field.label,
      controller: TextEditingController(
        text: value is String ? value : value?.toString(),
      ),
      valueType: field.type.toValueType,
      options: field.options?.lock,
      fieldRendering: field.fieldValueRenderingType.toValueTypeRenderingType,
      relevantFields: field.fieldRules?.lock,
    );
  }

  void disposeControllers(IList<FormFieldModel> formFields) {
    for (var field in formFields) {
      field.controller.dispose();
    }
  }

  Future<FormFieldModel> updateField(
      FormFieldModel fieldUiModel, String? warningMessage) async {
    return warningMessage != null
        ? fieldUiModel.setError(warningMessage)
        : fieldUiModel;
  }

  Future<StoreResult> save(String fieldKey, String? value) async {
    final SyncableEntity syncableEntity =
        (await syncableQuery.byId(_entityUid).getOne())!;
    final DynamicForm form = (await D2Remote.formModule.form
        .where(attribute: 'activity', value: syncableEntity.activity)
        .getOne())!;
    final fields = form.fields?.lock ?? IList([]);
    final valueType =
        fields.firstOrNullWhere((t) => t.name == fieldKey)?.type.toValueType;

    dynamic newValue = value;
    if (valueType == ValueType.Image && value != null) {
      newValue = await saveFileResource(value);
    }

    IMap<String, dynamic> entityMap = IMap(syncableEntity.toJson());
    if (!entityMap.containsKey(fieldKey)) {
      return StoreResult(
          uid: fieldKey,
          valueStoreResult: ValueStoreResult.KEY_IS_NOT_IN_ENTITY);
    }

    final storedDataValue = entityMap.get(fieldKey);
    if (storedDataValue != newValue) {
      syncableQuery.mergeMode =
          value != null ? MergeMode.Merge : MergeMode.Replace;
      entityMap = entityMap.add(fieldKey, value);
      final newEntity = syncableQuery.fromJsonInstance(entityMap.unlock);
      final updatedEntityCount = await syncableQuery
          .setData(newEntity)
          .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));

      return StoreResult(
          uid: fieldKey,
          valueStoreResult: updatedEntityCount > 0
              ? ValueStoreResult.VALUE_CHANGED
              : ValueStoreResult.VALUE_HAS_NOT_CHANGED);
    } else {
      return StoreResult(
          uid: fieldKey,
          valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED);
    }
  }

  Future<String?> userFriendlyValue(String? value, ValueType? valueType) async {
    if (value.isNullOrEmpty) {
      return value;
    }

    final checkResult = await check(valueType, value!);
    return checkResult ? valueTypeValue(valueType, value) : null;
  }

  Future<bool> check(ValueType? valueType, String value) async {
    if (valueType != null) {
      if (valueType.isNumeric) {
        return double.tryParse(value) != null;
      } else {
        switch (valueType) {
          case ValueType.FileResource:
          case ValueType.Image:
            return (await D2Remote.fileResourceModule.fileResource
                    .byId(value)
                    .getOne()) !=
                null;
          case ValueType.OrganisationUnit:
            return (await D2Remote.assignmentModuleD.assignment
                    .byId(value)
                    .getOne()) !=
                null;
          default:
            return true;
        }
      }
    }
    return false;
  }

  Future<String?> valueTypeValue(ValueType? valueType, String value) async {
    switch (valueType) {
      case ValueType.OrganisationUnit:
        return (await D2Remote.organisationUnitModule.organisationUnit
                .byId(value)
                .getOne())
            ?.displayName;
      case ValueType.Image:
      case ValueType.FileResource:
        final fileResource =
            await D2Remote.fileResourceModule.fileResource.byId(value).getOne();
        return fileResource?.localFilePath ?? '';
      case ValueType.Date:
        return sdk.DateUtils.uiDateFormat()
            .format(sdk.DateUtils.databaseDateFormatNoSeconds().parse(value));
      case ValueType.DateTime:
        return sdk.DateUtils.dateTimeFormat()
            .format(sdk.DateUtils.databaseDateFormatNoSeconds().parse(value));
      case ValueType.Time:
        return sdk.DateUtils.timeFormat()
            .format(sdk.DateUtils.timeFormat().parse(value));
      default:
        return value;
    }
  }

  Future<String> saveFileResource(String path) async {
    return '';
  }
}