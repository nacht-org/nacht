import 'package:flutter/material.dart';

class MuteTile extends StatelessWidget {
  const MuteTile({
    super.key,
    required this.muted,
    required this.child,
  });

  final bool muted;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        textColor: muted ? theme.colorScheme.onSurface.withAlpha(0x73) : null,
        selectedColor: muted ? theme.colorScheme.primary.withAlpha(0x73) : null,
      ),
      child: child,
    );
  }
}
