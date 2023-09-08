import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import 'package:nacht/features/features.dart';
import 'package:nacht/widgets/widgets.dart';

typedef DestinationCallback = void Function(WidgetRef ref);

class Destination {
  final DestinationBuilder builder;
  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final DestinationCallback? onTap;

  const Destination({
    required this.builder,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.onTap,
  });
}

abstract class Destinations {
  static const library = Destination(
    builder: libraryBuilder,
    label: 'Library',
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
  );

  static const updates = Destination(
    builder: updatesBuilder,
    label: 'Updates',
    icon: Icon(Icons.update_outlined),
    selectedIcon: Icon(Icons.update),
    onTap: updatesTap,
  );

  static void updatesTap(WidgetRef ref) =>
      ref.read(routerProvider).push(const DownloadRoute());

  static const history = Destination(
    builder: historyBuilder,
    label: "History",
    icon: Icon(Icons.history_outlined),
    selectedIcon: Icon(Icons.history),
  );

  static const browse = Destination(
    builder: browseBuilder,
    label: 'Browse',
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
  );

  static const more = Destination(
    builder: moreBuilder,
    label: 'More',
    icon: Icon(Icons.more_horiz_outlined),
    selectedIcon: Icon(Icons.more_horiz),
  );
}

const destinations = [
  Destinations.library,
  Destinations.updates,
  Destinations.history,
  Destinations.browse,
  Destinations.more,
];

Widget libraryBuilder(BuildContext context) => const LibraryPage();
Widget updatesBuilder(BuildContext context) => const UpdatesPage();
Widget historyBuilder(BuildContext context) => const HistoryPage();
Widget browseBuilder(BuildContext context) => const BrowsePage();
Widget moreBuilder(BuildContext context) => const MorePage();
