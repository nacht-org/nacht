import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nacht/widgets/widgets.dart';

class SearchBar extends HookWidget implements PreferredSizeWidget {
  const SearchBar({
    super.key,
    this.onSubmitted,
  });

  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return AppBar(
      title: ClearableTextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        textInputAction: TextInputAction.search,
        autofocus: true,
        onSubmitted: onSubmitted,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
