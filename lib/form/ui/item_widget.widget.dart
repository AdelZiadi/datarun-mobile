import 'package:mass_pro/sdk/core/common/value_type.dart';
import 'package:mass_pro/sdk/core/common/value_type_rendering_type.dart';
import 'package:mass_pro/sdk/core/program/section_rendering_type.dart';
import 'package:flutter/material.dart';

import 'package:mass_pro/commons/custom_widgets/fields/form_edit_text.widget.dart';
import 'package:mass_pro/commons/custom_widgets/form_card.dart';
import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:mass_pro/form/model/field_ui_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, this.item});

  final FieldUiModel? item;

  @override
  Widget build(BuildContext context) {
    return item != null ? getWidgetByType(item!) : const SizedBox.shrink();
  }

  Widget getWidgetByType(FieldUiModel? item) {
    final valueType = item?.valueType;
    return when(valueType, {
      ValueType.Age: () => FormEditText(item: item),
      [ValueType.Date, ValueType.Time, ValueType.DateTime]: () =>
          FormEditText(item: item),

      ValueType.LongText: () => FormEditText(item: item),
      ValueType.OrganisationUnit: () => Text(
            '$valueType Field, value: ${item?.value}',
            style: const TextStyle(fontSize: 20),
          ),
      ValueType.Coordinate: () => Text(
            '$valueType Field, value: ${item?.value}',
            style: const TextStyle(fontSize: 20),
          ),
      ValueType.Image: () => Text(
            '$valueType Field, value: ${item?.value}',
            style: const TextStyle(fontSize: 20),
          ), //layout.form_picture
      ValueType.Text: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_edit_text_custom
          ),
      [ValueType.TrueOnly, ValueType.Boolean]: () =>
          when(item?.fieldRendering, {
            [
              ValueTypeRenderingType.HORIZONTAL_RADIOBUTTONS,
              ValueTypeRenderingType.VERTICAL_RADIOBUTTONS,
              ValueTypeRenderingType.DEFAULT
            ]: () => Text(
                  '$valueType Field, value: ${item?.value}',
                  style: const TextStyle(fontSize: 20),
                ),
            ValueTypeRenderingType.TOGGLE: () => when(valueType, {
                  ValueType.TrueOnly: () => Text(
                        '$valueType Field, value: ${item?.value}',
                        style: const TextStyle(fontSize: 20),
                      ),
                }).orElse(
                  () => Text('$valueType Field, value: ${item?.value}',
                      style: const TextStyle(fontSize: 20)),
                ),
            [
              ValueTypeRenderingType.HORIZONTAL_CHECKBOXES,
              ValueTypeRenderingType.VERTICAL_CHECKBOXES
            ]: () => Text(
                  '$valueType Field, value: ${item?.value}',
                  style: const TextStyle(fontSize: 20),
                ),
          }).orElse(() => Text(
                '$valueType Field, value: ${item?.value}',
                style: const TextStyle(fontSize: 20),
              )),

      ValueType.Letter: () => FormEditText(item: item), //layout.form_letter
      ValueType.PhoneNumber: () =>
          FormEditText(item: item), //layout.form_phone_number
      ValueType.Email: () => FormEditText(item: item), //layout.form_email
      ValueType.Number: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_number
          ),
      ValueType.UnitInterval: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_unit_interval
          ),
      ValueType.Percentage: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_percentage
          ),
      ValueType.Integer: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_integer
          ),
      ValueType.IntegerPositive: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_integer_positive
          ),
      ValueType.IntegerNegative: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_integer_negative
          ),
      ValueType.IntegerZeroOrPositive: () => getLayoutForOptionSet(
          item, FormEditText(item: item) //layout.form_integer_zero_positive
          ),
      ValueType.URL: () => FormEditText(item: item), //layout.form_url
      [
        ValueType.Reference,
        ValueType.GeoJson,
        ValueType.FileResource,
        ValueType.Username,
        ValueType.TrackerAssociate
      ]: () => Text(
            '$valueType Field, value: ${item?.value}',
            style: const TextStyle(fontSize: 20),
          ), //layout.form_unsupported
      null: () => const SizedBox.shrink(),
    }).orElse(() => FormEditText(item: item)); //layout.form_edit_text_custom);

    // switch (valueType) {
    //   case ValueType.AGE:
    //     return FormEditText(item: item);
    //   case ValueType.DATE:
    //   case ValueType.TIME:
    //   case ValueType.DATETIME:
    //     return FormEditText(item: item);
    //   case ValueType.LONG_TEXT:
    //     return FormEditText(item: item);
    //   case ValueType.ORGANISATION_UNIT:
    //     return Text(
    //       '$valueType Field, value: ${item?.value}',
    //       style: const TextStyle(fontSize: 20),
    //     );
    //   case ValueType.COORDINATE:
    //     return Text(
    //       '$valueType Field, value: ${item?.value}',
    //       style: const TextStyle(fontSize: 20),
    //     );
    //   case ValueType.IMAGE:
    //     return Text(
    //       '$valueType Field, value: ${item?.value}',
    //       style: const TextStyle(fontSize: 20),
    //     ); //layout.form_picture
    //   case ValueType.TEXT:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_edit_text_custom
    //         );
    //   case ValueType.TRUE_ONLY:
    //   case ValueType.BOOLEAN:
    //     switch (item?.fieldRendering) {
    //       case ValueTypeRenderingType.HORIZONTAL_RADIOBUTTONS:
    //       case ValueTypeRenderingType.VERTICAL_RADIOBUTTONS:
    //       case ValueTypeRenderingType.DEFAULT:
    //         return Text(
    //           '$valueType Field, value: ${item?.value}',
    //           style: const TextStyle(fontSize: 20),
    //         );
    //       case ValueTypeRenderingType.TOGGLE:
    //         switch (valueType) {
    //           case ValueType.TRUE_ONLY:
    //             return Text(
    //               '$valueType Field, value: ${item?.value}',
    //               style: const TextStyle(fontSize: 20),
    //             );
    //           default:
    //             return Text(
    //               '$valueType Field, value: ${item?.value}',
    //               style: const TextStyle(fontSize: 20),
    //             );
    //         }
    //       case ValueTypeRenderingType.HORIZONTAL_CHECKBOXES:
    //       case ValueTypeRenderingType.VERTICAL_CHECKBOXES:
    //         return Text(
    //           '$valueType Field, value: ${item?.value}',
    //           style: const TextStyle(fontSize: 20),
    //         );
    //       default:
    //         return Text(
    //           '$valueType Field, value: ${item?.value}',
    //           style: const TextStyle(fontSize: 20),
    //         );
    //     }
    //   case ValueType.LETTER:
    //     return FormEditText(item: item); //layout.form_letter
    //   case ValueType.PHONE_NUMBER:
    //     return FormEditText(item: item); //layout.form_phone_number
    //   case ValueType.EMAIL:
    //     return FormEditText(item: item); //layout.form_email
    //   case ValueType.NUMBER:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_number
    //         );
    //   case ValueType.UNIT_INTERVAL:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_unit_interval
    //         );
    //   case ValueType.PERCENTAGE:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_percentage
    //         );
    //   case ValueType.INTEGER:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_integer
    //         );
    //   case ValueType.INTEGER_POSITIVE:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_integer_positive
    //         );
    //   case ValueType.INTEGER_NEGATIVE:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_integer_negative
    //         );
    //   case ValueType.INTEGER_ZERO_OR_POSITIVE:
    //     return getLayoutForOptionSet(
    //         item, FormEditText(item: item) //layout.form_integer_zero_positive
    //         );
    //   case ValueType.URL:
    //     return FormEditText(item: item); //layout.form_url
    //   case ValueType.REFERENCE:
    //   case ValueType.GEOJSON:
    //   case ValueType.FILE_RESOURCE:
    //   case ValueType.USERNAME:
    //   case ValueType.TRACKER_ASSOCIATE:
    //     return Text(
    //       '$valueType Field, value: ${item?.value}',
    //       style: const TextStyle(fontSize: 20),
    //     ); //layout.form_unsupported
    //   default:
    //     return FormEditText(item: item); //layout.form_edit_text_custom
    // }
  }

  Widget getWidgetForSection() {
    return const FormCard(
      // isLast: true,
      children: <Widget>[],
    ); //layout.form_section;
  }

  Widget getLayoutForOptionSet(
      FieldUiModel? item,
      /*@LayoutRes*/
      Widget defaultLayout) {
    if (shouldRenderAsMatrixImage(
        item?.optionSet, item?.sectionRenderingType, item?.fieldRendering)) {
      return FormEditText(item: item); //layout.form_option_set_matrix
    } else if (shouldRenderAsSelector(item?.optionSet, item?.fieldRendering)) {
      return FormEditText(
          item:
              item); /*const Text(
        'form_option_set_selector',
        style: TextStyle(fontSize: 20),
      );*/ // layout.form_option_set_selector
    } else if (shouldRenderAsSpinner(item?.optionSet)) {
      return FormEditText(
          item:
              item); /*const Text(
        'form_option_set_spinner',
        style: TextStyle(fontSize: 20),
      );*/ // layout.form_option_set_spinner
    } else if (shouldRenderAsScan(item?.fieldRendering)) {
      return FormEditText(
          item:
              item); /*const Text(
        'form_scan',
        style: TextStyle(fontSize: 20),
      );*/ // layout.form_scan
    } else if (shouldRenderAsSelector(item?.optionSet, item?.fieldRendering)) {
      return FormEditText(
          item:
              item); /*const Text(
        'form_option_set_selector',
        style: TextStyle(fontSize: 20),
      );*/ // layout.form_option_set_selector
    } else {
      return defaultLayout;
    }
  }

  bool shouldRenderAsScan(ValueTypeRenderingType? renderingType) {
    switch (renderingType) {
      case ValueTypeRenderingType.QR_CODE:
      case ValueTypeRenderingType.BAR_CODE:
        return true;
      default:
        return false;
    }
  }

  bool shouldRenderAsSpinner(String? optionSet) {
    return optionSet != null;
  }

  bool shouldRenderAsSelector(
      String? optionSet, ValueTypeRenderingType? renderingType) {
    bool isOptionSet = optionSet != null;
    bool isSelectorRendering = false;
    switch (renderingType) {
      case ValueTypeRenderingType.HORIZONTAL_RADIOBUTTONS:
      case ValueTypeRenderingType.VERTICAL_RADIOBUTTONS:
      case ValueTypeRenderingType.HORIZONTAL_CHECKBOXES:
      case ValueTypeRenderingType.VERTICAL_CHECKBOXES:
        isSelectorRendering = true;
        break;
      default:
        isSelectorRendering = false;
    }
    return isOptionSet && isSelectorRendering;
  }

  bool shouldRenderAsMatrixImage(
      String? optionSet,

      /// from the renderType of the item's programStageSection,
      /// programStageSection?.renderType()?.mobile()?.type()
      SectionRenderingType? sectionRenderingType,

      /// from the renderType of the item's programStageDataElement,
      /// programStageDataElement.renderType()?.mobile()
      ValueTypeRenderingType? renderingType) {
    final bool isOptionSet = optionSet != null;
    final bool isDefaultRendering = renderingType == null ||
        renderingType == ValueTypeRenderingType.DEFAULT;
    final bool isSectionRenderingMatrix =
        (sectionRenderingType ?? SectionRenderingType.LISTING) !=
            SectionRenderingType.LISTING;
    return isOptionSet && isDefaultRendering && isSectionRenderingMatrix;
  }
}
