import 'package:auto_route/auto_route.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/pages/pages.dart';

part 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>(
  (ref) => AppRouter(),
  name: 'RouterProvider',
);

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      page: HomePage,
      initial: true,
      children: [
        AutoRoute(page: LibraryPage),
        AutoRoute(page: UpdatesPage),
        AutoRoute(page: BrowsePage),
        AutoRoute(page: MorePage),
      ],
    ),
    AutoRoute(page: ImportFromUrlPage, path: 'import-from-url'),
    AutoRoute(
      page: PopularPage,
      path: 'popular',
    ),
    AutoRoute(
      page: NovelPage,
      path: 'novel',
    ),
    AutoRoute(page: WebViewPage, path: 'webview'),
  ],
)
class AppRouter extends _$AppRouter {}
