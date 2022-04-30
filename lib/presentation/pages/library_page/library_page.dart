import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:chapturn/presentation/controllers/library/library_provider.dart';
import 'package:chapturn/presentation/widgets/novel_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../novel_page/data/novel_page_args.dart';

class LibraryPage extends HookConsumerWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(libraryProvider.notifier).reload();
      return null;
    }, []);

    return CustomScrollView(
      slivers: [
        Consumer(builder: (context, ref, child) {
          final entities = ref.watch(libraryProvider);
          if (entities.isEmpty) {
            return const SliverToBoxAdapter();
          }

          final entity = entities.single;

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final novel = entity.novels[index];

                return NovelGridCard(
                  title: novel.title,
                  coverUrl: novel.coverUrl,
                  cover: novel.cover,
                  onTap: () => context.router.push(
                    NovelRoute(
                      novel: NovelEntityArgument.complete(novel),
                      crawler: null,
                    ),
                  ),
                );
              },
              childCount: entity.novels.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
          );
        })
      ],
    );
  }
}
