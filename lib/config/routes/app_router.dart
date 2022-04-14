import 'package:auto_route/auto_route.dart';
import 'package:chapturn/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: HomePage, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
