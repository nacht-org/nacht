import 'package:flutter/material.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Center(
      child: IconTheme(
        data: theme.iconTheme.copyWith(
          size: 48.0,
          color: theme.colorScheme.secondary,
        ),
        child: child,
      ),
    );
  }
}
