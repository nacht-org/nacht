import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nacht/core/nacht_theme/nacht_theme.dart';

class ImplicitAnimatedBottomBar extends HookWidget {
  const ImplicitAnimatedBottomBar({
    Key? key,
    required this.visible,
    required this.child,
  }) : super(key: key);

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      initialValue: visible ? 1.0 : 0.0,
      duration: kShortAnimationDuration,
    );

    useEffect(() {
      visible ? controller.forward() : controller.reverse();
      return null;
    }, [visible]);

    return AnimatedBottomBar(controller: controller, child: child);
  }
}

class AnimatedBottomBar extends StatelessWidget {
  const AnimatedBottomBar({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final Widget child;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: -1.0,
      child: child,
    );
  }
}
