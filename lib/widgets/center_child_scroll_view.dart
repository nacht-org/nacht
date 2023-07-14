import 'package:flutter/material.dart';

class CenterChildScrollView extends StatelessWidget {
  const CenterChildScrollView({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        padding: padding,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - (padding?.vertical ?? 0),
            ),
            child: Center(
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
