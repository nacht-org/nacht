import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlignTabBar extends StatelessWidget with PreferredSizeWidget {
  const AlignTabBar({
    Key? key,
    required this.child,
    this.alignment = Alignment.centerLeft,
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
