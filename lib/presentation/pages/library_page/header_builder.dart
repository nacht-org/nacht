import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Widget> buildLibraryHeader(BuildContext context, bool innerBoxIsScrolled) {
  return [
    const SliverAppBar(
      title: Text('Library'),
    ),
  ];
}
