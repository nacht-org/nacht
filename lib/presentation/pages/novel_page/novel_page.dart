import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/string.dart';
import 'data/novel_page_args.dart';
import 'providers/providers.dart';
import 'widgets/action_bar.dart';
import 'widgets/description.dart';
import 'widgets/info.dart';
import 'widgets/notice_listener.dart';
import 'widgets/tags.dart';

export 'data/novel_page_args.dart';

class NovelPage extends StatelessWidget {
  const NovelPage({
    Key? key,
    required this.novel,
    required this.crawler,
  }) : super(key: key);

  final NovelEntityArgument novel;
  final Crawler? crawler;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        novelArgProvider.overrideWithValue(novel),
        crawlerArgProvider.overrideWithValue(crawler),
      ],
      child: const Scaffold(
        body: NovelPageSplit(),
      ),
    );
  }
}

class NovelPageSplit extends HookConsumerWidget {
  const NovelPageSplit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(novelPageState);
    final novelArg = ref.read(novelArgProvider);
    useEffect(() {
      novelArg.mapOrNull(
        partial: (value) => ref.read(novelPageState.notifier).reload(),
      );
      return null;
    }, []);

    return state.when(
      partial: (novel) {
        return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(novel.title),
              floating: true,
              forceElevated: innerBoxIsScrolled,
            )
          ],
          body: const NoticeListener(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    top: 24.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  sliver: NovelInfo(),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loaded: (novel) {
        return ProviderScope(
          overrides: [
            novelOverrideProvider.overrideWithValue(novel),
          ],
          child: const NovelPageView(),
        );
      },
    );
  }
}

class NovelPageView extends HookConsumerWidget {
  const NovelPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final novelArg = ref.watch(novelArgProvider);
    useEffect(() {
      novelArg.when(
        partial: (_) => {},
        complete: (_) async {
          return ref.read(novelProvider.notifier).reload();
        },
      );
      return null;
    }, []);

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        Consumer(builder: (context, ref, child) {
          final novel = ref.watch(novelProvider);

          return SliverAppBar(
            title: innerBoxIsScrolled ? Text(novel.title) : null,
            floating: true,
            forceElevated: innerBoxIsScrolled,
          );
        }),
      ],
      body: RefreshIndicator(
        onRefresh: ref.read(novelProvider.notifier).fetch,
        child: NoticeListener(
          child: CustomScrollView(
            slivers: [
              buildPadding(sliver: const NovelInfo(), top: 24),
              buildPadding(sliver: const ActionBar(), top: 0, bottom: 8),
              HookConsumer(builder: (context, ref, child) {
                final more = ref.watch(novelMoreProvider);
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
                            description: more.description,
                            expanded: expanded,
                          ),
                          const SizedBox(height: 8),
                          Tags(
                            tags: more.tags,
                            expanded: expanded,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Consumer(builder: (context, ref, child) {
                final chapterCount = ref.watch(chapterCountProvider);

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
                final items = ref.watch(itemsProvider);

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
                          onTap: () {},
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
