import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:chapturn/core/core.dart';

class Destination {
  final PageRouteInfo route;
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const Destination({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

const destinations = [
  Destination(
    route: LibraryRoute(),
    label: 'Library',
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
  ),
  Destination(
    route: UpdatesRoute(),
    label: 'Updates',
    icon: Icon(Icons.update_outlined),
    selectedIcon: Icon(Icons.update),
  ),
  Destination(
    route: BrowseRoute(),
    label: 'Browse',
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
  ),
  Destination(
    route: MoreRoute(),
    label: 'More',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
  ),
];
