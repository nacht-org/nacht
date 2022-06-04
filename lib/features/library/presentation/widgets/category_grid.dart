import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/library/presentation/provider/category_novels_family.dart';

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({Key? key, required this.category}) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryNovelsFamily(category.id));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stack) {
        return LoadingError(
          message: Text(error.toString()),
        );
      },
      data: (data) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final novel = data[index];

            return NovelGridCard(
              title: novel.title,
              coverUrl: novel.coverUrl,
              cover: novel.cover,
              onTap: () => context.router.push(
                NovelRoute(
                  either: NovelEither.complete(novel),
                ),
              ),
            );
          },
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 2 / 3,
          ),
        );
      },
    );
  }
}
