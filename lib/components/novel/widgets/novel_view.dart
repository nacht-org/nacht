import 'package:auto_route/auto_route.dart';
import 'package:chapturn/components/novel/provider/description_info_provider.dart';
import 'package:chapturn/core/core.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/novel/novel_data.dart';
import '../../../provider/provider.dart';
import 'action_bar.dart';
import 'description.dart';
import 'info.dart';
import 'tags.dart';

class NovelView extends HookConsumerWidget {
  const NovelView({
    Key? key,
    required this.data,
    required this.crawler,
    required this.load,
  }) : super(key: key);

  final NovelData data;
  final Crawler? crawler;
  final bool load;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = NovelInput(data, crawler);
    final novel = ref.watch(novelProvider(input));
    final notifier = ref.watch(novelProvider(input).notifier);

    useEffect(() {
      notifier.reload();
      return null;
    }, []);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        Consumer(builder: (context, ref, child) {
          return SliverAppBar(
            title: innerBoxIsScrolled ? Text(novel.title) : null,
            floating: true,
            forceElevated: innerBoxIsScrolled,
          );
        }),
      ],
      body: RefreshIndicator(
        onRefresh: notifier.fetch,
        child: CustomScrollView(
          slivers: [
            buildPadding(sliver: const EssentialSection(), top: 24, bottom: 8),
            buildPadding(sliver: ActionBar(input: input), top: 0, bottom: 8),
            HookConsumer(builder: (context, ref, child) {
              final description = ref.watch(descriptionInfoProvider(novel));
              final expanded = useState(false);

              return buildPadding(
                top: 0,
                bottom: 8,
                sliver: SliverToBoxAdapter(
                  child: GestureDetector(
                    onTap: () => expanded.value = !expanded.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Description(
                          description: description.description,
                          expanded: expanded,
                        ),
                        const SizedBox(height: 8),
                        Tags(
                          tags: description.tags,
                          expanded: expanded,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            Consumer(builder: (context, ref, child) {
              final chapterCount = ref.watch(chapterCountProvider(novel));

              return SliverToBoxAdapter(
                child: ListTile(
                  title: Text(
                    '$chapterCount Chapter'.pluralize(
                      test: (_) => chapterCount > 1,
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: const Icon(Icons.filter_list),
                  onTap: () {},
                  dense: true,
                ),
              );
            }),
            Consumer(builder: (context, ref, child) {
              final items = ref.watch(chapterListProvider(novel));

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return items[index].when(
                      volume: (volume) => ListTile(
                        title: Text(
                          volume.name.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        dense: true,
                      ),
                      chapter: (chapter) => ListTile(
                        title: Text(
                          chapter.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(chapter.updated.toString()),
                        onTap: () => context.router.push(
                          ReaderRoute(novel: novel, chapter: chapter),
                        ),
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildPadding({
    required Widget sliver,
    double left = 16.0,
    double top = 16.0,
    double right = 16.0,
    double bottom = 16.0,
  }) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      sliver: sliver,
    );
  }
}
