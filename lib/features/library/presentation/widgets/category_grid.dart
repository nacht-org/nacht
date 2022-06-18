import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../presentation.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({
    Key? key,
    required this.category,
    required this.pinned,
  }) : super(key: key);

  final CategoryData category;
  final bool pinned;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNovelsFamily(category.id));

    final slivers = state.when(
      loading: () => [],
      error: (error, stack) => [
        SliverFillLoadingError(
          message: Text(error.toString()),
        )
      ],
      data: (data) => [
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final novel = data[index];

                return NovelGridCard(
                  title: novel.title,
                  coverUrl: novel.coverUrl,
                  onTap: () => context.router.push(
                    NovelRoute(
                      type: NovelType.novel(novel),
                    ),
                  ),
                );
              },
              childCount: data.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 2 / 3,
            ),
          ),
        )
      ],
    );

    return CustomScrollView(
      slivers: [
        if (pinned)
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
        ...slivers,
      ],
    );
  }
}
