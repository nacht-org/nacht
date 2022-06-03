import 'package:flutter/material.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/core/core.dart';

import 'package:nacht/features/features.dart';

class Destination {
  final DestinationBuilder builder;
  final String label;
  final Widget icon;
  final Widget selectedIcon;

  const Destination({
    required this.builder,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

const destinations = [
  Destination(
    builder: libraryBuilder,
    label: 'Library',
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
  ),
  Destination(
    builder: updatesBuilder,
    label: 'Updates',
    icon: Icon(Icons.update_outlined),
    selectedIcon: Icon(Icons.update),
  ),
  Destination(
    builder: browseBuilder,
    label: 'Browse',
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
  ),
  Destination(
    builder: moreBuilder,
    label: 'More',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
  ),
];

Widget libraryBuilder(BuildContext context) => const LibraryPage();
Widget updatesBuilder(BuildContext context) => const UpdatesPage();
Widget browseBuilder(BuildContext context) => const BrowsePage();
Widget moreBuilder(BuildContext context) => const MorePage();
