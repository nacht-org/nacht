import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:chapturn/presentation/controllers/browse_notifier.dart';
import 'package:chapturn/utils/iso_lang.dart';
import 'package:chapturn/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crawlerFactories = ref.watch(availableCrawlers);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Browse'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text('Import from url'),
                    onTap: () =>
                        context.router.push(const ImportFromUrlRoute()),
                  ),
                ];
              },
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final meta = crawlerFactories[index].meta();
              final lang =
                  langFromCode(meta.lang)?['name'] ?? meta.lang.capitalize();

              return ListTile(
                title: Text(meta.name),
                subtitle: Text(lang),
                trailing: TextButton(
                  child: const Text('Latest'),
                  onPressed: () {},
                ),
                onTap: () {},
              );
            },
            childCount: crawlerFactories.length,
          ),
        )
      ],
    );
  }
}
