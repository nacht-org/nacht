import 'package:chapturn/domain/entities/partial_novel_entity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NovelPage extends StatelessWidget {
  const NovelPage({Key? key, required this.novel}) : super(key: key);

  final PartialNovelEntity novel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, isInnerBoxScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: Text(novel.title),
              floating: true,
              snap: true,
              forceElevated: isInnerBoxScrolled,
            ),
          )
        ],
        body: Consumer(builder: ((context, ref, child) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    LimitedBox(
                      maxHeight: 200,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AspectRatio(
                            aspectRatio: 2 / 3,
                            child: Image.network(
                              novel.thumbnailUrl!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  novel.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 3,
                                ),
                                Text(
                                  novel.author ?? 'Unknown',
                                  style: Theme.of(context).textTheme.labelLarge,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          );
        })),
      ),
    );
  }
}
