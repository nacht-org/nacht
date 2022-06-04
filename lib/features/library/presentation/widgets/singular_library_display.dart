import 'package:flutter/material.dart';
import 'package:nacht/common/common.dart';

import 'category_grid.dart';

class SingularLibraryDisplay extends StatelessWidget {
  const SingularLibraryDisplay({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryData category;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Library'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
        ),
      ],
      body: CategoryGrid(category: category),
    );
  }
}
