import 'package:flutter/material.dart';

typedef ExpandableSheetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

Future<T?> showExpandableBottomSheet<T>({
  required BuildContext context,
  double initialChildSize = 0.4,
  double maxChildSize = 1,
  double minChildSize = 0.4,
  required ExpandableSheetBuilder builder,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          snap: true,
          builder: builder,
        ),
      );
    },
  );
}
