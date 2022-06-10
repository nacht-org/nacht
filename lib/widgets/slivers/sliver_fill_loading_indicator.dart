import 'package:flutter/material.dart';

class SliverFillLoadingIndicator extends StatelessWidget {
  const SliverFillLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
