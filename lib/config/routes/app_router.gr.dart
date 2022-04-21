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
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    ImportFromUrlRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ImportFromUrlPage());
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
          child: NovelPage(key: args.key, novel: args.novel));
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
        RouteConfig(HomeRoute.name, path: '/', children: [
          RouteConfig(LibraryRoute.name,
              path: 'library-page', parent: HomeRoute.name),
          RouteConfig(UpdatesRoute.name,
              path: 'updates-page', parent: HomeRoute.name),
          RouteConfig(BrowseRoute.name,
              path: 'browse-page', parent: HomeRoute.name),
          RouteConfig(MoreRoute.name, path: 'more-page', parent: HomeRoute.name)
        ]),
        RouteConfig(ImportFromUrlRoute.name, path: 'import-from-url'),
        RouteConfig(PopularRoute.name, path: 'popular'),
        RouteConfig(NovelRoute.name, path: 'novel')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ImportFromUrlPage]
class ImportFromUrlRoute extends PageRouteInfo<void> {
  const ImportFromUrlRoute()
      : super(ImportFromUrlRoute.name, path: 'import-from-url');

  static const String name = 'ImportFromUrlRoute';
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
  NovelRoute({Key? key, required PartialNovelEntity novel})
      : super(NovelRoute.name,
            path: 'novel', args: NovelRouteArgs(key: key, novel: novel));

  static const String name = 'NovelRoute';
}

class NovelRouteArgs {
  const NovelRouteArgs({this.key, required this.novel});

  final Key? key;

  final PartialNovelEntity novel;

  @override
  String toString() {
    return 'NovelRouteArgs{key: $key, novel: $novel}';
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
