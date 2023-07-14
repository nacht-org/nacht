import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

class SliverFillEmptyIndicator extends StatelessWidget {
  const SliverFillEmptyIndicator({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: EmptyIndicator(
        icon: icon,
        label: label,
      ),
    );
  }
}
