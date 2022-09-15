import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../providers/history_provider.dart';

class HistoryBody extends ConsumerWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesValue = ref.watch(historyProvider);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text("History"),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ],
      body: entriesValue.when(
        data: (entries) => MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final entry = entries[index];

              return entry.when(
                date: (date) => RelativeDateTile(date: date),
                history: (history) => ListTile(
                  title: Text(history.novel.title),
                  subtitle: Text(history.chapter.title),
                  trailing: Text(
                      "${history.updatedAt.hour}:${history.updatedAt.minute}"),
                ),
              );
            },
            itemCount: entries.length,
          ),
        ),
        error: (error, stack) => LoadingError(
          message: Text(error.toString()),
        ),
        loading: () => const SizedBox.shrink(),
      ),
    );
  }
}
