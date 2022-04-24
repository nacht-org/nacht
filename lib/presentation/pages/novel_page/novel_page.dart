import 'package:chapturn/presentation/pages/novel_page/providers/novel_page_notice.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/providers.dart';
import 'package:chapturn/presentation/pages/novel_page/widgets/action_bar.dart';
import 'package:chapturn/utils/string.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/novel_page_args.dart';
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
        body: NovelPageView(),
      ),
    );
  }
}

class NovelPageView extends ConsumerWidget {
  const NovelPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<NovelPageNotice?>(noticeProvider, (previous, next) {
      if (next == null) {
        return;
      }

      final snackBar = next.when(
        error: (message) => SnackBar(content: Text(message)),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        Consumer(builder: (context, ref, child) {
          final state = ref.watch(novelPageState);
          return state.when(
            partial: (novel) => SliverAppBar(
              title: Text(novel.title),
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
            loaded: (novel) => SliverAppBar(
              title: Text(novel.title),
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          );
        }),
      ],
      body: CustomScrollView(
        slivers: [
          Consumer(builder: (context, ref, child) {
            final info = ref.watch(novelInfoProvider);

            return buildPadding(
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 170,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: info.coverUrl.fold(
                              () => null,
                              (url) => Image.network(
                                url,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                info.title,
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 3,
                              ),
                              Text(
                                info.author.toNullable() ?? 'Unknown',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Icon(Icons.done_all, size: 16.0),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    info.status.fold(
                                          () => 'Unknown',
                                          (status) => status.name.capitalize(),
                                        ) +
                                        info.meta.fold(
                                          () => '',
                                          (meta) => ' • ${meta.name}',
                                        ),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            );
          }),
          buildPadding(sliver: ActionBar(), top: 0, bottom: 8),
          Consumer(builder: (context, ref, child) {
            final more = ref.watch(novelMoreProvider);

            return more.fold(
              () => const SliverToBoxAdapter(),
              (more) => buildPadding(
                top: 0,
                sliver: SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      ClipRect(
                        child: SizedOverflowBox(
                          alignment: Alignment.topLeft,
                          size: Size.fromHeight(8 * 10),
                          child: Column(
                            children: [
                              for (final para in more.description)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(para),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Theme.of(context).canvasColor,
                                Theme.of(context).canvasColor.withOpacity(0),
                              ],
                            ),
                          ),
                          height: 8 * 8,
                        ),
                        bottom: 0,
                        left: 0,
                        right: 0,
                      ),
                      Positioned(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                radius: 0.8,
                                colors: [
                                  Theme.of(context).canvasColor,
                                  Theme.of(context).canvasColor.withOpacity(0),
                                ],
                              ),
                            ),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                        bottom: 0,
                        left: 0,
                        right: 0,
                      ),
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
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
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
                        style: Theme.of(context).textTheme.labelMedium,
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
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
