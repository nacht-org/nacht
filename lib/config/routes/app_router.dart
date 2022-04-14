import 'package:auto_route/auto_route.dart';
import 'package:chapturn/presentation/pages/home_page/browse_page.dart';
import 'package:chapturn/presentation/pages/home_page/home_page.dart';
import 'package:chapturn/presentation/pages/home_page/library_page.dart';
import 'package:chapturn/presentation/pages/home_page/more_page.dart';
import 'package:chapturn/presentation/pages/home_page/updates_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      page: HomePage,
      children: [
        AutoRoute(page: LibraryPage),
        AutoRoute(page: UpdatesPage),
        AutoRoute(page: BrowsePage),
        AutoRoute(page: MorePage),
      ],
      initial: true,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
