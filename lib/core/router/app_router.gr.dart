// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    PopularRoute.name: (routeData) {
      final args = routeData.argsAs<PopularRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PopularPage(key: args.key, crawlerFactory: args.crawlerFactory));
    },
    NovelRoute.name: (routeData) {
      final args = routeData.argsAs<NovelRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: NovelPage(key: args.key, either: args.either));
    },
    WebViewRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: WebViewPage(
              key: args.key, title: args.title, initialUrl: args.initialUrl));
    },
    CategoryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CategoryPage());
    },
    ReaderRoute.name: (routeData) {
      final args = routeData.argsAs<ReaderRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ReaderPage(
              key: args.key,
              novel: args.novel,
              chapter: args.chapter,
              incomplete: args.incomplete));
    },
    LibraryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LibraryPage());
    },
    UpdatesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const UpdatesPage());
    },
    BrowseRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const BrowsePage());
    },
    MoreRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MorePage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(HomeRoute.name, path: '/home', children: [
          RouteConfig(LibraryRoute.name,
              path: 'library-page', parent: HomeRoute.name),
          RouteConfig(UpdatesRoute.name,
              path: 'updates-page', parent: HomeRoute.name),
          RouteConfig(BrowseRoute.name,
              path: 'browse-page', parent: HomeRoute.name),
          RouteConfig(MoreRoute.name, path: 'more-page', parent: HomeRoute.name)
        ]),
        RouteConfig(PopularRoute.name, path: 'popular'),
        RouteConfig(NovelRoute.name, path: 'novel'),
        RouteConfig(WebViewRoute.name, path: 'webview'),
        RouteConfig(CategoryRoute.name, path: 'categories'),
        RouteConfig(ReaderRoute.name, path: 'reader')
      ];
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [PopularPage]
class PopularRoute extends PageRouteInfo<PopularRouteArgs> {
  PopularRoute({Key? key, required CrawlerFactory crawlerFactory})
      : super(PopularRoute.name,
            path: 'popular',
            args: PopularRouteArgs(key: key, crawlerFactory: crawlerFactory));

  static const String name = 'PopularRoute';
}

class PopularRouteArgs {
  const PopularRouteArgs({this.key, required this.crawlerFactory});

  final Key? key;

  final CrawlerFactory crawlerFactory;

  @override
  String toString() {
    return 'PopularRouteArgs{key: $key, crawlerFactory: $crawlerFactory}';
  }
}

/// generated route for
/// [NovelPage]
class NovelRoute extends PageRouteInfo<NovelRouteArgs> {
  NovelRoute({Key? key, required NovelEither either})
      : super(NovelRoute.name,
            path: 'novel', args: NovelRouteArgs(key: key, either: either));

  static const String name = 'NovelRoute';
}

class NovelRouteArgs {
  const NovelRouteArgs({this.key, required this.either});

  final Key? key;

  final NovelEither either;

  @override
  String toString() {
    return 'NovelRouteArgs{key: $key, either: $either}';
  }
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({Key? key, required String title, required String initialUrl})
      : super(WebViewRoute.name,
            path: 'webview',
            args: WebViewRouteArgs(
                key: key, title: title, initialUrl: initialUrl));

  static const String name = 'WebViewRoute';
}

class WebViewRouteArgs {
  const WebViewRouteArgs(
      {this.key, required this.title, required this.initialUrl});

  final Key? key;

  final String title;

  final String initialUrl;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, title: $title, initialUrl: $initialUrl}';
  }
}

/// generated route for
/// [CategoryPage]
class CategoryRoute extends PageRouteInfo<void> {
  const CategoryRoute() : super(CategoryRoute.name, path: 'categories');

  static const String name = 'CategoryRoute';
}

/// generated route for
/// [ReaderPage]
class ReaderRoute extends PageRouteInfo<ReaderRouteArgs> {
  ReaderRoute(
      {Key? key,
      required NovelData novel,
      required ChapterData chapter,
      required bool incomplete})
      : super(ReaderRoute.name,
            path: 'reader',
            args: ReaderRouteArgs(
                key: key,
                novel: novel,
                chapter: chapter,
                incomplete: incomplete));

  static const String name = 'ReaderRoute';
}

class ReaderRouteArgs {
  const ReaderRouteArgs(
      {this.key,
      required this.novel,
      required this.chapter,
      required this.incomplete});

  final Key? key;

  final NovelData novel;

  final ChapterData chapter;

  final bool incomplete;

  @override
  String toString() {
    return 'ReaderRouteArgs{key: $key, novel: $novel, chapter: $chapter, incomplete: $incomplete}';
  }
}

/// generated route for
/// [LibraryPage]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute() : super(LibraryRoute.name, path: 'library-page');

  static const String name = 'LibraryRoute';
}

/// generated route for
/// [UpdatesPage]
class UpdatesRoute extends PageRouteInfo<void> {
  const UpdatesRoute() : super(UpdatesRoute.name, path: 'updates-page');

  static const String name = 'UpdatesRoute';
}

/// generated route for
/// [BrowsePage]
class BrowseRoute extends PageRouteInfo<void> {
  const BrowseRoute() : super(BrowseRoute.name, path: 'browse-page');

  static const String name = 'BrowseRoute';
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute() : super(MoreRoute.name, path: 'more-page');

  static const String name = 'MoreRoute';
}
