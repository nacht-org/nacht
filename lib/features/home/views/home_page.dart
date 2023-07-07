import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/nht/nht.dart';
import 'package:nacht/widgets/widgets.dart';

import '../models/models.dart';
import '../providers/providers.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const initialIndex = 0;
    final currentIndex = useState(0);

    usePostFrameCallback((timeStamp) {
      ref.read(applicationLoadedProvider).init();
    });

    return WillPopScope(
      onWillPop: () async {
        final hasModalRoute =
            ModalRoute.of(context)?.willHandlePopInternally ?? false;
        if (!hasModalRoute && currentIndex.value != initialIndex) {
          currentIndex.value = initialIndex;
          return false;
        }
        return true;
      },
      child: LazyIndexedStack(
        initialIndex: initialIndex,
        currentIndex: currentIndex.value,
        destinations: destinations.map((item) => item.builder).toList(),
        duration: kShortAnimationDuration,
        builder: (context, child, animation) {
          return Scaffold(
            body: FadeTransition(
              opacity: animation,
              child: MediaQuery(
                data: MediaQuery.of(context),
                child: child,
              ),
            ),
            extendBody: true,
            bottomNavigationBar: HookConsumer(
              builder: (context, ref, child) {
                final controller = useAnimationController(
                  initialValue: 1,
                  duration: kShortAnimationDuration,
                );

                ref.listen<NavigationInfo>(
                  navigationProvider,
                  (prev, next) {
                    final prevForceHide = prev?.forceHide ?? false;
                    if (next.forceHide && !prevForceHide) {
                      controller.reverse();
                    } else if (!next.forceHide && prevForceHide) {
                      controller.forward();
                    }
                  },
                );

                return AnimatedBottomBar(
                  controller: controller,
                  child: NavigationBar(
                    selectedIndex: currentIndex.value,
                    onDestinationSelected: (index) =>
                        currentIndex.value = index,
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
            ),
          );
        },
      ),
    );
  }
}
