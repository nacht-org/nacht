import 'package:auto_route/auto_route.dart';
import 'package:chapturn/config/routes/app_router.dart';
import 'package:chapturn/presentation/pages/browse_page/header_builder.dart';
import 'package:chapturn/presentation/pages/library_page/header_builder.dart';
import 'package:flutter/material.dart';

import '../../browse_page/browse_page.dart';

typedef HeaderBuilder = List<Widget> Function(
    BuildContext context, bool innerBoxIsScrolled);

class Destination {
  final PageRouteInfo route;
  final HeaderBuilder headerBuilder;
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const Destination({
    required this.route,
    required this.headerBuilder,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

List<Widget> buildEmptyHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [];
}

const destinations = [
  Destination(
    route: LibraryRoute(),
    headerBuilder: buildLibraryHeader,
    label: 'Library',
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
  ),
  Destination(
    route: UpdatesRoute(),
    headerBuilder: buildEmptyHeader,
    label: 'Updates',
    icon: Icon(Icons.update_outlined),
    selectedIcon: Icon(Icons.update),
  ),
  Destination(
    route: BrowseRoute(),
    headerBuilder: buildBrowseHeader,
    label: 'Browse',
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
  ),
  Destination(
    route: MoreRoute(),
    headerBuilder: buildEmptyHeader,
    label: 'More',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
  ),
];
