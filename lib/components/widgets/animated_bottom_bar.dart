import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nacht/core/core.dart';

import 'bottom_bar.dart';

class AnimatedBottomBar extends HookWidget {
  const AnimatedBottomBar({
    Key? key,
    required this.child,
    required this.visible,
  }) : super(key: key);

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      initialValue: visible ? 1.0 : 0.0,
      duration: kShortAnimationDuration,
    );

    final animation = useMemoized(
      () => CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
    );
    final offset = useMemoized(
      () => Tween(begin: const Offset(0, 1), end: const Offset(0, 0)),
    );

    useEffect(() {
      visible ? controller.forward() : controller.reverse();
      return null;
    }, [visible]);

    return SizeTransition(
      sizeFactor: animation,
      child: SlideTransition(
        position: offset.animate(animation),
        child: BottomBar(child: child),
      ),
    );
  }
}
