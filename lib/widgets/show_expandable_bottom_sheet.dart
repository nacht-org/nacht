import 'package:flutter/material.dart';

typedef ExpandableSheetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

Future<T?> showExpandableBottomSheet<T>({
  required BuildContext context,
  required ExpandableSheetBuilder builder,
  double initialChildSize = 0.4,
  double maxChildSize = 1,
  double minChildSize = 0.4,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext modelContext) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(modelContext).pop(),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          snap: true,
          builder: (sheetContext, scrollController) {
            final mediaQuery =
                ExpandableSheetOverride.of(context)?.mediaQuery ??
                    MediaQuery.of(context);

            return Material(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        mediaQuery.size.height - mediaQuery.viewPadding.top,
                  ),
                  child: builder(sheetContext, scrollController),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

class ExpandableSheetOverride extends InheritedWidget {
  const ExpandableSheetOverride({
    Key? key,
    required this.child,
    required this.mediaQuery,
  }) : super(key: key, child: child);

  @override
  // ignore: overridden_fields
  final Widget child;
  final MediaQueryData mediaQuery;

  static ExpandableSheetOverride? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ExpandableSheetOverride>();
  }

  @override
  bool updateShouldNotify(ExpandableSheetOverride oldWidget) {
    return mediaQuery != oldWidget.mediaQuery;
  }
}
