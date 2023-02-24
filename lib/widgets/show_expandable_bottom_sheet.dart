import 'package:flutter/material.dart';

typedef ExpandableSheetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

Future<T?> showExpandableBottomSheet<T>({
  required BuildContext context,
  required ExpandableSheetBuilder builder,
  double initialChildSize = 0.5,
  double maxChildSize = 1,
  double minChildSize = 0.5,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    useSafeArea: true,
    builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          snap: true,
          builder: (sheetContext, scrollController) {
            final theme = Theme.of(context);

            // Prevent tap events in container from bubbling up.
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Material(
                elevation: 1,
                surfaceTintColor: theme.colorScheme.surfaceTint,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.0),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: builder(sheetContext, scrollController),
              ),
            );
          },
        ),
      );
    },
  );
}
