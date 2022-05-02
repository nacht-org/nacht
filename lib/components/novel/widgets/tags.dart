import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({
    Key? key,
    required this.tags,
    required this.expanded,
  }) : super(key: key);

  final List<String> tags;
  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      for (final tag in tags)
        Chip(
          label: Text(
            tag,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
    ];

    if (children.isEmpty) {
      return const SizedBox.shrink();
    } else if (expanded.value) {
      return Wrap(
        children: children,
        spacing: 8.0,
        runSpacing: 8.0,
      );
    } else {
      return SingleChildScrollView(
        child: Row(
          children: children
              .map((child) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: child,
                  ))
              .toList(),
        ),
        scrollDirection: Axis.horizontal,
      );
    }
  }
}
