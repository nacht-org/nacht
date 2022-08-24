import 'package:flutter/material.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/widgets/widgets.dart';

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
      body: DestinationTransition(
        child: CategoryGrid(
          category: category,
          pinned: false,
        ),
      ),
    );
  }
}
