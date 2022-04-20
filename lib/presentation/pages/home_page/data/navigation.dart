import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:flutter/material.dart';

class NavigationTab {
  final PageRouteInfo route;
  final String label;
  final IconData iconData;

  const NavigationTab({
    required this.route,
    required this.label,
    required this.iconData,
  });
}

const navigationItems = [
  NavigationTab(
    route: LibraryRoute(),
    label: 'Library',
    iconData: Icons.library_books,
  ),
  NavigationTab(
    route: UpdatesRoute(),
    label: 'Updates',
    iconData: Icons.update,
  ),
  NavigationTab(
    route: BrowseRoute(),
    label: 'Browse',
    iconData: Icons.explore,
  ),
  NavigationTab(
    route: MoreRoute(),
    label: 'More',
    iconData: Icons.more_horiz,
  ),
];
