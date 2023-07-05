import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nacht/core/core.dart';

class Destination {
  final PageRouteInfo<dynamic> route;
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
    label: 'Library',
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
    route: LibraryRoute(),
  ),
  Destination(
    label: 'Updates',
    icon: Icon(Icons.update_outlined),
    selectedIcon: Icon(Icons.update),
    route: UpdatesRoute(),
  ),
  Destination(
    label: "History",
    icon: Icon(Icons.history_outlined),
    selectedIcon: Icon(Icons.history),
    route: HistoryRoute(),
  ),
  Destination(
    label: 'Browse',
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
    route: BrowseRoute(),
  ),
  Destination(
    label: 'More',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
    route: MoreRoute(),
  ),
];
