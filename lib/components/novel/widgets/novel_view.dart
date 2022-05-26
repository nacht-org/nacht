import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/components/novel/model/head_info.dart';
import 'package:nacht/components/novel/provider/description_info_provider.dart';
import 'package:nacht/components/novel/widgets/action_bar.dart';
import 'package:nacht/components/novel/widgets/chapter_list.dart';
import 'package:nacht/components/novel/widgets/description.dart';
import 'package:nacht/components/novel/widgets/novel_head.dart';
import 'package:nacht/components/novel/widgets/tags.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/domain/entities/novel/novel_data.dart';
import 'package:nacht/provider/provider.dart';

class NovelView extends HookConsumerWidget {
  const NovelView({
    Key? key,
    required this.data,
    required this.crawler,
    required this.head,
    required this.load,
  }) : super(key: key);

  final NovelData data;
  final Crawler? crawler;
  final HeadInfo head;
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

    return Scaffold(
      body: NestedScrollView(
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
          child: Scrollbar(
            interactive: true,
            child: CustomScrollView(
              slivers: [
                buildPadding(sliver: NovelHead(head: head), top: 24, bottom: 8),
                buildPadding(
                    sliver: ActionBar(input: input), top: 0, bottom: 8),
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
                ChapterList(novel: novel),
                const SliverFloatingActionButtonPadding(),
                const SliverBottomPadding(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () => notifier.pushUnread(),
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
