import 'package:chapturn/components/search/provider/search_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components.dart';

class SearchBar extends HookConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(searchTextProvider.notifier);
    final controller = useTextEditingController();

    return SliverAppBar(
      leading: buildSearchBackButton(context, controller),
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
        onChanged: (value) => notifier.state = value,
        onSubmitted: onSubmitted,
      ),
      floating: floating,
      forceElevated: forceElevated,
    );
  }

  Widget buildSearchBackButton(
    BuildContext context,
    TextEditingController controller,
  ) {
    return IconButton(
      onPressed: () {
        controller.clear();
        Navigator.maybePop(context);
      },
      icon: const Icon(Icons.close),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }
}
