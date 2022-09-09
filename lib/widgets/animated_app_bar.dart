import 'package:flutter/material.dart';

class AnimatedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnimatedAppBar({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final AnimationController controller;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    final offset = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);

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
