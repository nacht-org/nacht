import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'data/navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      lazyLoad: false,
      homeIndex: 0,
      routes: destinations.map((item) => item.route).toList(),
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) => tabsRouter.setActiveIndex(index),
            destinations: List.generate(destinations.length, (index) {
              final destination = destinations[index];
              return NavigationDestination(
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
                label: destination.label,
              );
            }),
          ),
        );
      },
    );
  }
}
