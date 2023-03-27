// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    PopularRoute.name: (routeData) {
      final args = routeData.argsAs<PopularRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PopularPage(
          key: args.key,
          crawlerFactory: args.crawlerFactory,
        ),
      );
    },
    NovelRoute.name: (routeData) {
      final args = routeData.argsAs<NovelRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NovelPage(
          key: args.key,
          type: args.type,
        ),
      );
    },
    ReaderRoute.name: (routeData) {
      final args = routeData.argsAs<ReaderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReaderPage(
          key: args.key,
          novel: args.novel,
          chapter: args.chapter,
        ),
      );
    },
    CategoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    WebViewRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WebViewPage(
          key: args.key,
          title: args.title,
          initialUrl: args.initialUrl,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    AboutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutPage(),
      );
    },
    DownloadRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DownloadPage(),
      );
    },
  };
}

/// generated route for
/// [PopularPage]
class PopularRoute extends PageRouteInfo<PopularRouteArgs> {
  PopularRoute({
    Key? key,
    required CrawlerFactory crawlerFactory,
    List<PageRouteInfo>? children,
  }) : super(
          PopularRoute.name,
          args: PopularRouteArgs(
            key: key,
            crawlerFactory: crawlerFactory,
          ),
          initialChildren: children,
        );

  static const String name = 'PopularRoute';

  static const PageInfo<PopularRouteArgs> page =
      PageInfo<PopularRouteArgs>(name);
}

class PopularRouteArgs {
  const PopularRouteArgs({
    this.key,
    required this.crawlerFactory,
  });

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
  NovelRoute({
    Key? key,
    required NovelType type,
    List<PageRouteInfo>? children,
  }) : super(
          NovelRoute.name,
          args: NovelRouteArgs(
            key: key,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'NovelRoute';

  static const PageInfo<NovelRouteArgs> page = PageInfo<NovelRouteArgs>(name);
}

class NovelRouteArgs {
  const NovelRouteArgs({
    this.key,
    required this.type,
  });

  final Key? key;

  final NovelType type;

  @override
  String toString() {
    return 'NovelRouteArgs{key: $key, type: $type}';
  }
}

/// generated route for
/// [ReaderPage]
class ReaderRoute extends PageRouteInfo<ReaderRouteArgs> {
  ReaderRoute({
    Key? key,
    required NovelData novel,
    required ChapterData chapter,
    List<PageRouteInfo>? children,
  }) : super(
          ReaderRoute.name,
          args: ReaderRouteArgs(
            key: key,
            novel: novel,
            chapter: chapter,
          ),
          initialChildren: children,
        );

  static const String name = 'ReaderRoute';

  static const PageInfo<ReaderRouteArgs> page = PageInfo<ReaderRouteArgs>(name);
}

class ReaderRouteArgs {
  const ReaderRouteArgs({
    this.key,
    required this.novel,
    required this.chapter,
  });

  final Key? key;

  final NovelData novel;

  final ChapterData chapter;

  @override
  String toString() {
    return 'ReaderRouteArgs{key: $key, novel: $novel, chapter: $chapter}';
  }
}

/// generated route for
/// [CategoryPage]
class CategoryRoute extends PageRouteInfo<void> {
  const CategoryRoute({List<PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    required String title,
    required String initialUrl,
    List<PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(
            key: key,
            title: title,
            initialUrl: initialUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static const PageInfo<WebViewRouteArgs> page =
      PageInfo<WebViewRouteArgs>(name);
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.title,
    required this.initialUrl,
  });

  final Key? key;

  final String title;

  final String initialUrl;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, title: $title, initialUrl: $initialUrl}';
  }
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AboutPage]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DownloadPage]
class DownloadRoute extends PageRouteInfo<void> {
  const DownloadRoute({List<PageRouteInfo>? children})
      : super(
          DownloadRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
