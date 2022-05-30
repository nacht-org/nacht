import 'package:auto_route/auto_route.dart';
import 'package:nacht/components/components.dart';
import 'package:nacht/components/home/provider/destination_animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/destinations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0,
      routes: destinations.map((item) => item.route).toList(),
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: ProviderScope(
            overrides: [
              destinationAnimationProvider.overrideWithValue(animation)
            ],
            child: child,
          ),
          bottomNavigationBar: Consumer(builder: (context, ref, child) {
            final visible = ref.watch(navigationVisibleProvider);

            return AnimatedBottomBar(
              visible: visible,
              child: NavigationBar(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: (index) =>
                    tabsRouter.setActiveIndex(index),
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
          }),
        );
      },
    );
  }
}
