import 'package:chapturn/presentation/controllers/bottom_navigation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationItem {
  final Widget component;
  final String label;
  final IconData iconData;

  const NavigationItem(this.component, this.label, this.iconData);
}

const navigationItems = [
  NavigationItem(Text('Library'), 'Library', Icons.library_books),
  NavigationItem(Text('Updates'), 'Updates', Icons.update),
  NavigationItem(Text('Explore'), 'Explore', Icons.explore),
  NavigationItem(Text('More'), 'More', Icons.more_horiz),
];

class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndex);

    return BottomNavigationBar(
      items: List.generate(navigationItems.length, (index) {
        final item = navigationItems[index];

        return BottomNavigationBarItem(
          icon: Icon(item.iconData),
          label: item.label,
        );
      }),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) =>
          ref.read(bottomNavigationIndex.notifier).setIndex(index),
    );
  }
}

class AppNavigationBody extends ConsumerWidget {
  const AppNavigationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndex);

    return IndexedStack(
      index: currentIndex,
      children: navigationItems
          .map((item) => Center(
                child: item.component,
              ))
          .toList(),
    );
  }
}
