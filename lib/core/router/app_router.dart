import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/components.dart';
import '../../features/features.dart';

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
      initial: true,
      page: SplashPage,
    ),
    AutoRoute(
      path: '/home',
      page: HomePage,
    ),
    AutoRoute(page: PopularPage, path: 'popular'),
    AutoRoute(page: NovelPage, path: 'novel'),
    AutoRoute(page: WebViewPage, path: 'webview'),
    AutoRoute(page: CategoryPage, path: 'categories'),
    AutoRoute(page: ReaderPage, path: 'reader'),
  ],
)
class AppRouter extends _$AppRouter {}
