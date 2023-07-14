import 'package:flutter/material.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({
    Key? key,
    required this.icon,
    required this.label,
    this.child,
  }) : super(key: key);

  final Widget icon;
  final Widget label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: theme.iconTheme.copyWith(
              size: 48.0,
              color: theme.textTheme.bodyMedium?.color,
            ),
            child: icon,
          ),
          const SizedBox(height: 8.0),
          DefaultTextStyle(
            style: theme.textTheme.bodyMedium ?? const TextStyle(),
            child: label,
          ),
          if (child != null) ...[
            const SizedBox(height: 8.0),
            child!,
          ],
        ],
      ),
    );
  }
}
