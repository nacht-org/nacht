import 'package:flutter/material.dart';

List<Widget> buildLibraryHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    SliverAppBar(
      title: const Text('Library'),
      floating: true,
      forceElevated: innerBoxIsScrolled,
    ),
  ];
}
