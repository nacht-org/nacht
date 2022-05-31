import 'package:nacht/components/widgets/loading_error.dart';
import 'package:flutter/cupertino.dart';

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
