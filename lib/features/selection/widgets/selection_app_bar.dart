import 'package:flutter/material.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    super.key,
    required this.title,
    this.onSelectAllPressed,
    this.onInversePressed,
    this.bottom,
  });

  final Widget title;
  final VoidCallback? onSelectAllPressed;
  final VoidCallback? onInversePressed;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const CloseButton(),
      title: title,
      elevation: 3,
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

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
