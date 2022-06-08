import 'package:flutter/cupertino.dart';

import '../loading_error.dart';

class SliverFillLoadingError extends StatelessWidget {
  const SliverFillLoadingError({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  final Widget message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverFillRemaining(
        hasScrollBody: false,
        child: LoadingError(message: message, onRetry: onRetry),
      ),
    );
  }
}
