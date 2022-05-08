import 'package:auto_route/auto_route.dart';
import 'package:chapturn/components/widgets/novel_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/core.dart';
import '../novel/novel_page.dart';
import 'provider/library_provider.dart';

List<Widget> buildLibraryHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    SliverAppBar(
      title: const Text('Library'),
      floating: true,
      forceElevated: innerBoxIsScrolled,
    ),
  ];
}

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
                      either: NovelEither.complete(novel),
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
