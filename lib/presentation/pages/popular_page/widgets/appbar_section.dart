import 'package:auto_route/auto_route.dart';
import 'package:chapturn/presentation/controllers/popular_page/popular_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Widget buildNormalAppbar(BuildContext context) {
  return Consumer(builder: (context, ref, child) {
    final meta = ref.watch(crawlerMetaProvider);

    return SliverAppBar(
      title: Text(meta.name),
      floating: true,
      actions: [
        IconButton(
          onPressed: () => AutoTabsRouter.of(context).setActiveIndex(1),
          icon: const Icon(Icons.search),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Latest'),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  });
}

Widget buildSearchAppbar(BuildContext context) {
  return Consumer(
    builder: (context, ref, child) {
      return SliverAppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.headline6,
          autofocus: true,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AutoTabsRouter.of(context).pop(),
        ),
        floating: true,
      );
    },
  );
}
