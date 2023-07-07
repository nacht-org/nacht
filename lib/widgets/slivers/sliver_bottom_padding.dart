import 'package:flutter/material.dart';

class SliverBottomPadding extends StatelessWidget {
  const SliverBottomPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.viewPaddingOf(context);

    return SliverToBoxAdapter(
      child: SizedBox(height: padding.bottom),
    );
  }
}
