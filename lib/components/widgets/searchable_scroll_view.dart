import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class SearchableScrollView extends HookWidget {
  const SearchableScrollView({Key? key}) : super(key: key);

  StateProvider<String> get searchtext;

  StateProvider<bool> get isSearching;

  List<Widget> buildBody(BuildContext context, WidgetRef ref);

  Widget buildAppBar(
    BuildContext context,
    bool innerBoxIsScrolled,
    WidgetRef ref,
  );

  Widget buildSearchBar(
    BuildContext context,
    bool innerBoxIsScrolled,
    WidgetRef ref,
    TextEditingController controller,
  );

  void buildInit(BuildContext context);

  void beginSearch(BuildContext context, Reader read) {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: () {
        read(isSearching.notifier).state = false;
      }),
    );

    read(isSearching.notifier).state = true;
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
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final _isSearching = ref.watch(isSearching);

              return _isSearching
                  ? buildSearchBar(context, innerBoxIsScrolled, ref, controller)
                  : buildAppBar(context, innerBoxIsScrolled, ref);
            },
          ),
        )
      ],
      body: Consumer(
        builder: (context, ref, child) => CustomScrollView(
          slivers: buildBody(context, ref),
        ),
      ),
    );
  }

  Widget buildDefaultSearchBar(
    BuildContext context,
    bool innerBoxIsScrolled,
    WidgetRef ref, {
    required TextEditingController controller,
    VoidCallback? onEditingComplete,
    TextInputAction? textInputAction,
  }) {
    final value = ref.watch(searchtext);

    return SliverAppBar(
      leading: buildSearchBackButton(context, controller),
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        textInputAction: textInputAction ?? TextInputAction.search,
        autofocus: true,
        onChanged: (value) => ref.read(searchtext.notifier).state = value,
        onEditingComplete: onEditingComplete,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
      actions: [
        if (value.isNotEmpty)
          IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
      ],
      floating: true,
      forceElevated: innerBoxIsScrolled,
    );
  }

  IconButton getSearchAction(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => beginSearch(context, ref.read),
      icon: const Icon(Icons.search),
    );
  }
}
