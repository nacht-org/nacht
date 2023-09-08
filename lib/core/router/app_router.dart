import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht_sources/nacht_sources.dart';

part 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>(
  (ref) => AppRouter(),
  name: 'RouterProvider',
);

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/popular', page: PopularRoute.page),
    AutoRoute(path: '/novel', page: NovelRoute.page),
    AutoRoute(path: '/webview', page: WebViewRoute.page),
    AutoRoute(path: '/categories', page: CategoryRoute.page),
    AutoRoute(path: '/reader', page: ReaderRoute.page),
    AutoRoute(path: '/downloads', page: DownloadRoute.page),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
    AutoRoute(path: '/about', page: AboutRoute.page),
    AutoRoute(
      path: '/new-release',
      page: NewReleaseRoute.page,
      fullscreenDialog: true,
    ),
  ];
}
