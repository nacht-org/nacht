import 'package:chapturn/components/updates/provider/updates_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';

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
          itemBuilder: (context, index) => updates[index].map(
            date: (state) => ListTile(
              title: Text(
                state.date,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              dense: true,
            ),
            chapter: (state) => ListTile(
              leading: AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    state.novel.coverUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                state.novel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                state.chapter.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          itemCount: updates.length,
        );
      }),
    );
  }
}
