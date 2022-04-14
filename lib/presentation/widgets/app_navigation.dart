import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final PageRouteInfo route;
  final String label;
  final IconData iconData;

  const NavigationItem(this.route, this.label, this.iconData);
}

const navigationItems = [
  NavigationItem(LibraryRoute(), 'Library', Icons.library_books),
  NavigationItem(UpdatesRoute(), 'Updates', Icons.update),
  NavigationItem(BrowseRoute(), 'Browse', Icons.explore),
  NavigationItem(MoreRoute(), 'More', Icons.more_horiz),
];
