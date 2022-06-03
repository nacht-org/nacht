import 'package:flutter/material.dart';

import 'animation_provider.dart';

class DestinationTransition extends StatelessWidget {
  const DestinationTransition({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: AnimationProvider.of(context).animation,
      child: child,
    );
  }
}
