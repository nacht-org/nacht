import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../presentation.dart';

class NovelView extends HookConsumerWidget {
  const NovelView({
    Key? key,
    required this.data,
    required this.load,
  }) : super(key: key);

  final NovelData data;
  final bool load;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = NovelInput(data);
    final novel = ref.watch(novelFamily(input));
    final notifier = ref.watch(novelFamily(input).notifier);

    final crawlerFactory = ref.watch(crawlerFactoryFamily(novel.url));
    final crawler = crawlerFactory != null
        ? ref.watch(crawlerFamily(crawlerFactory))
        : null;

    final selection = ref.watch(novelSelectionProvider);
    SelectionNotifier.handleRoute(novelSelectionProvider, ref, context);

    useEffect(() {
      notifier.reload();
      return null;
    }, []);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          if (!selection.active)
            SliverAppBar(
              title: innerBoxIsScrolled ? Text(novel.title) : null,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          if (selection.active)
            SliverSelectionAppBar(
              title: Text('${selection.selected.length}'),
              onSelectAllPressed: () => ref
                  .read(novelSelectionProvider.notifier)
                  .addAll(novel.chapters.map((c) => c.id)),
              onInversePressed: () => ref
                  .read(novelSelectionProvider.notifier)
                  .flipAll(novel.chapters.map((c) => c.id)),
            )
        ],
        body: RefreshIndicator(
          onRefresh: () async => notifier.fetch(crawler),
          child: Scrollbar(
            interactive: true,
            child: CustomScrollView(
              slivers: [
                buildPadding(
                  sliver: NovelHead(head: HeadInfo.fromNovel(novel)),
                  top: 24,
                  bottom: 8,
                ),
                buildPadding(
                  sliver: ActionBar(input: input),
                  top: 0,
                  bottom: 8,
                ),
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
                SliverToBoxAdapter(
                  child: ListTile(
                    title: Text(
                      '${novel.chapters.length} Chapter'.pluralize(
                        test: (_) => novel.chapters.length > 1,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: const Icon(Icons.filter_list),
                    onTap: () {},
                    dense: true,
                  ),
                ),
                ChapterList(novel: novel),
                const SliverFloatingActionButtonPadding(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: selection.active
          ? null
          : FloatingActionButton(
              onPressed: notifier.readFirstUnread,
              child: const Icon(Icons.play_arrow),
            ),
      extendBody: true,
      bottomNavigationBar: AnimatedBottomBar(
        visible: selection.active,
        child: CustomBottomBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  final selection = ref.read(novelSelectionProvider);
                  notifier.setReadAt(selection.selected, true);
                  context.router.pop();
                },
                tooltip: 'Mark as read',
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  final selection = ref.read(novelSelectionProvider);
                  notifier.setReadAt(selection.selected, false);
                  context.router.pop();
                },
                tooltip: 'Mark as unread',
              ),
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
