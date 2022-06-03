import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../components.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key, required this.category}) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final novel = category.novels[index];

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
      itemCount: category.novels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 2 / 3,
      ),
    );
  }
}
