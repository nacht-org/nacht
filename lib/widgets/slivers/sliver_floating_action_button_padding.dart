import 'package:flutter/material.dart';

class SliverFloatingActionPadding extends StatelessWidget {
  const SliverFloatingActionPadding({Key? key, this.mini = false})
      : super(key: key);

  final bool mini;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: (mini ? 48 : 56) + 8),
    );
  }
}
