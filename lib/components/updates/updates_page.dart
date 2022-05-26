import 'package:auto_route/auto_route.dart';
import 'package:nacht/components/updates/provider/updates_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/updates/widgets/chapter_update_tile.dart';

import '../../core/core.dart';
import '../components.dart';

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
      body: HookConsumer(builder: (context, ref, child) {
        final updates = ref.watch(updatesProvider);
        useEffect(() {
          ref.read(updatesProvider.notifier).fetch();
        }, []);

        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) => updates[index].when(
            date: (date) => ListTile(
              title: Text(
                date,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
            ),
            chapter: (novel, chapter) =>
                ChapterUpdateTile(novel: novel, chapter: chapter),
          ),
          itemCount: updates.length,
        );
      }),
    );
  }
}
