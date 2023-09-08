import 'package:flutter/material.dart';
import 'package:nacht/widgets/widgets.dart';

class SliverSelectionAppBar extends StatelessWidget {
  const SliverSelectionAppBar({
    Key? key,
    required this.title,
    this.onSelectAllPressed,
    this.onInversePressed,
    this.bottom,
    this.floating = false,
  }) : super(key: key);

  final Widget title;
  final VoidCallback? onSelectAllPressed;
  final VoidCallback? onInversePressed;
  final PreferredSizeWidget? bottom;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const CloseBackButton(),
      title: title,
      floating: floating,
      pinned: true,
      forceElevated: true,
      actions: [
        if (onSelectAllPressed != null)
          IconButton(
            onPressed: onSelectAllPressed,
            icon: const Icon(Icons.select_all),
            tooltip: "Select all",
          ),
        if (onInversePressed != null)
          IconButton(
            onPressed: onInversePressed,
            icon: const Icon(Icons.deselect),
            tooltip: "Inverse selection",
          ),
      ],
      bottom: bottom,
    );
  }
}
