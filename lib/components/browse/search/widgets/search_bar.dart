import 'package:nacht/components/widgets/clearable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchBar extends HookWidget {
  const SearchBar({
    Key? key,
    this.onSubmitted,
    this.floating = true,
    this.forceElevated = false,
  }) : super(key: key);

  final void Function(String)? onSubmitted;

  final bool floating;
  final bool forceElevated;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return SliverAppBar(
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
      floating: floating,
      forceElevated: forceElevated,
    );
  }
}
