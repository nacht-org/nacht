import 'package:flutter/material.dart';

class AlignTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AlignTabBar({
    Key? key,
    required this.child,
    this.alignment = AlignmentDirectional.centerStart,
  }) : super(key: key);

  final AlignmentGeometry alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: child,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
