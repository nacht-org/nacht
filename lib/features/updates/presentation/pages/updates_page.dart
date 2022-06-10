import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/widgets/widgets.dart';

import '../presentation.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Updates'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ],
      body: DestinationTransition(
        child: HookConsumer(builder: (context, ref, child) {
          final updates = ref.watch(updatesProvider);

          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) => updates[index].when(
              date: (date) => DateUpdateTile(date: date),
              chapter: (novel, chapter) => ChapterUpdateTile(
                novel: novel,
                chapter: chapter,
              ),
            ),
            itemCount: updates.length,
          );
        }),
      ),
    );
  }
}
