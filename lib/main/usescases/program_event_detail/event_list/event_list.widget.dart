import 'package:d2_remote/modules/metadata/program/entities/program.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../commons/data/event_view_model.dart';
import '../../tei_dashboard/event_view_item.widget.dart';
import '../program_event_detail_view_model.dart';
import 'di/event_list_providers.dart';

/// ProgramEventDetailLiveAdapter
class EventList extends ConsumerStatefulWidget {
  const EventList({super.key, this.program});
  final Program? program;
  @override
  ConsumerState<EventList> createState() => _EventListState();
}

class _EventListState extends ConsumerState<EventList> {
  final ItemScrollController itemScrollController = ItemScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO(NMC): watch only length
    final filteredProgramEvents =
        ref.watch(filteredProgramEventsProvider).value;
    ref.listen<AsyncValue<List<EventModel>>>(filteredProgramEventsProvider,
        (previous, next) {
      next.maybeWhen(
        loading: () => Future(() => ref
            .read(programEventDetailModelProvider.notifier)
            .setProgress(true)),
        orElse: () => Future(() => ref
            .read(programEventDetailModelProvider.notifier)
            .setProgress(false)),
      );
    });

    return ScrollablePositionedList.builder(
      itemCount: filteredProgramEvents?.length ?? 0,
      itemBuilder: (BuildContext context, int index) => ProviderScope(
        overrides: [eventModelItemIndexProvider.overrideWith((_) => index)],
        child: EventViewItem(
          program: widget.program,
        ),
      ),
      itemScrollController: itemScrollController,
      // itemPositionsListener: itemPositionsListener,
    );
  }
}
