import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return LazyIndexedStack(
      initialIndex: 0,
      currentIndex: currentIndex.value,
      destinations: destinations.map((item) => item.builder).toList(),
      duration: kShortAnimationDuration,
      builder: (context, child, animation) {
        return Scaffold(
          body: AnimationProvider(
            animation: animation,
            child: child,
          ),
          bottomNavigationBar: Consumer(builder: (context, ref, child) {
            final visible = ref.watch(navigationVisibleProvider);

            return ImplicitAnimatedBottomBar(
              visible: visible,
              child: NavigationBar(
                selectedIndex: currentIndex.value,
                onDestinationSelected: (index) => currentIndex.value = index,
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
