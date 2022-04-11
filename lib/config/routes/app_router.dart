import 'package:auto_route/auto_route.dart';
import 'package:chapturn/main.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    // TODO: Replace placeholder with actual homepage
    AutoRoute(page: MyHomePage, initial: true)
  ],
)
class AppRouter extends _$AppRouter {}
