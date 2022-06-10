import 'package:flutter/material.dart';

class LoadingError extends StatelessWidget {
  const LoadingError({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  final Widget message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: theme.textTheme.titleLarge!,
            textAlign: TextAlign.center,
            child: message,
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
