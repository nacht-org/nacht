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
    CrawlerRoute.name: (routeData) {
      final args = routeData.argsAs<CrawlerRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              CrawlerPage(key: args.key, crawlerFactory: args.crawlerFactory));
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
    },
    PopularRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    SearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
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
        RouteConfig(CrawlerRoute.name, path: 'crawler', children: [
          RouteConfig('#redirect',
              path: '',
              parent: CrawlerRoute.name,
              redirectTo: 'popular',
              fullMatch: true),
          RouteConfig(PopularRoute.name,
              path: 'popular', parent: CrawlerRoute.name),
          RouteConfig(SearchRoute.name,
              path: 'search', parent: CrawlerRoute.name)
        ])
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
/// [CrawlerPage]
class CrawlerRoute extends PageRouteInfo<CrawlerRouteArgs> {
  CrawlerRoute(
      {Key? key,
      required CrawlerFactory crawlerFactory,
      List<PageRouteInfo>? children})
      : super(CrawlerRoute.name,
            path: 'crawler',
            args: CrawlerRouteArgs(key: key, crawlerFactory: crawlerFactory),
            initialChildren: children);

  static const String name = 'CrawlerRoute';
}

class CrawlerRouteArgs {
  const CrawlerRouteArgs({this.key, required this.crawlerFactory});

  final Key? key;

  final CrawlerFactory crawlerFactory;

  @override
  String toString() {
    return 'CrawlerRouteArgs{key: $key, crawlerFactory: $crawlerFactory}';
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

/// generated route for
/// [EmptyRouterPage]
class PopularRoute extends PageRouteInfo<void> {
  const PopularRoute() : super(PopularRoute.name, path: 'popular');

  static const String name = 'PopularRoute';
}

/// generated route for
/// [EmptyRouterPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: 'search');

  static const String name = 'SearchRoute';
}
