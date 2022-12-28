import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class NavigationOffset extends HookConsumerWidget {
  const NavigationOffset({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    return SizeTransition(
      sizeFactor: animation,
      child: const SizedBox(height: 80.0),
    );
  }
}
