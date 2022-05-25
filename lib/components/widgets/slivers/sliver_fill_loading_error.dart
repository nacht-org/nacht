import 'package:nacht/components/widgets/loading_error.dart';
import 'package:flutter/cupertino.dart';

class SliverFillLoadingError extends StatelessWidget {
  const SliverFillLoadingError({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Widget message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: LoadingError(message: message),
    );
  }
}
