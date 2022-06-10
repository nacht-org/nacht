import 'package:flutter/material.dart';

class SlidingPrefferedSize extends StatelessWidget
    implements PreferredSizeWidget {
  const SlidingPrefferedSize({
    Key? key,
    required this.child,
    required this.controller,
    required this.visible,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    final offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1));

    visible ? controller.reverse() : controller.forward();

    return SlideTransition(
      position: offset.animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }
}
