// Flutter imports:
import 'package:d2_remote/shared/entities/identifiable.entity.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../main/l10n/app_localizations.dart';
import '../../utils/mass_utils/formatting.dart';
import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'entity_base_fields.dart';

class EntityPresenter {
  EntityPresenter initialize(IdentifiableEntity? entity, BuildContext context) {
    this.entity = entity;
    this.context = context;

    return this;
  }

  IdentifiableEntity? entity;
  late BuildContext context;

  String? title({bool isNarrow = false}) {
    final L localization = L.of(context)!;
    String? name = entity?.displayName;

    // TODO replace with this: https://github.com/flutter/flutter/issues/45336
    if ((name ?? '').isEmpty) {
      name = L.of(context)!.lookup('pending');
    } //else if (name.length > 10) {
    return name;
    //}

    // if ([
    //   EntityType.client,
    //   EntityType.vendor,
    //   EntityType.project,
    //   EntityType.user,
    //   EntityType.product,
    // ].contains(entity.entityType) ||
    //     isNarrow) {
    //   return name;
    // } else {
    //   return '$type $name';
    // }
  }

  static List<String> getBaseFields() {
    return [
      EntityBaseFields.created.name,
      EntityBaseFields.last_updated.name,
      EntityBaseFields.uid.name,
    ];
  }

  Widget getField({required String field, required BuildContext context}) {
    final L localization = L.of(context)!;
    return when(field, {
      EntityBaseFields.status.name: () => Text(entity?.dirty ?? false
          ? L.of(context)!.lookup('not_synced')
          : L.of(context)!.lookup('synced')),
      EntityBaseFields.created.name: () => Text(L.of(context)!.lookup('created')),
      EntityBaseFields.last_updated.name: () =>
          Text(L.of(context)!.lookup('last_updated')),
      EntityBaseFields.uid.name: () => Text(L.of(context)!.lookup('uid')),
    }).orElse(() => Text('Error: $field not found'));
  }

  String presentCustomField(BuildContext context, String value) {
    if (['yes', 'no'].contains(value)) {
      final localization = L.of(context)!;
      return L.of(context)!.lookup(value);
    } else if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
      return formatDate(value, context);
    }
    return value;
  }
}

class TableTooltip extends StatelessWidget {
  const TableTooltip({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Text(
        message,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
