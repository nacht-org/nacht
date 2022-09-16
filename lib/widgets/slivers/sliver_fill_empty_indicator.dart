import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

class SliverFillEmptyIndicator extends StatelessWidget {
  const SliverFillEmptyIndicator({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: EmptyIndicator(
        child: child,
      ),
    );
  }
}
