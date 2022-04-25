import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.description,
    required this.expanded,
  }) : super(key: key);

  final List<String> description;
  final ValueNotifier<bool> expanded;

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final para in description)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(para),
          ),
      ],
    );

    if (!expanded.value) {
      child = Stack(
        children: [
          ClipRect(
            child: SizedOverflowBox(
              alignment: Alignment.topLeft,
              size: const Size.fromHeight(8 * 10),
              child: child,
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).canvasColor,
                    Theme.of(context).canvasColor.withOpacity(0),
                  ],
                ),
              ),
              height: 8 * 8,
            ),
            bottom: 0,
            left: 0,
            right: 0,
          ),
          Positioned(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.8,
                    colors: [
                      Theme.of(context).canvasColor,
                      Theme.of(context).canvasColor.withOpacity(0),
                    ],
                  ),
                ),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      );
    }

    return child;
  }
}
