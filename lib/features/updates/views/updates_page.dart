import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class UpdatesPage extends HookWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refreshIndicatorKey =
        useMemoized(() => GlobalKey<RefreshIndicatorState>());

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Updates'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
          actions: [
            Consumer(
              builder: (context, ref, child) {
                final isBusy = ref.watch(refreshProvider);

                return IconButton(
                  tooltip: "Refresh",
                  onPressed: isBusy
                      ? null
                      : () => refreshIndicatorKey.currentState!.show(),
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
      ],
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: DestinationTransition(
          child: Consumer(
            builder: (context, ref, child) {
              final updates = ref.watch(updatesProvider);
              final refreshNotifier = ref.watch(refreshProvider.notifier);

              return RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: refreshNotifier.refreshAll,
                child: Scrollbar(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) => updates[index].when(
                      date: (date) => DateUpdateTile(date: date),
                      chapter: (novel, chapter) => ChapterUpdateTile(
                        novel: novel,
                        chapter: chapter,
                      ),
                    ),
                    itemCount: updates.length,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
