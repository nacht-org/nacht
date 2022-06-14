import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht_sources/nacht_sources.dart';

part 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>(
  (ref) => AppRouter(),
  name: 'RouterProvider',
);

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(path: '/', page: SplashPage, initial: true),
    AutoRoute(path: '/home', page: HomePage),
    AutoRoute(path: '/popular', page: PopularPage),
    AutoRoute(path: '/novel', page: NovelPage),
    AutoRoute(path: '/webview', page: WebViewPage),
    AutoRoute(path: '/categories', page: CategoryPage),
    AutoRoute(path: '/reader', page: ReaderPage),
    AutoRoute(path: '/settings', page: SettingsPage),
    AutoRoute(path: '/about', page: AboutPage),
  ],
)
class AppRouter extends _$AppRouter {}
