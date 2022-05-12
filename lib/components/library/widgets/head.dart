import 'package:chapturn/components/components.dart';
import 'package:chapturn/components/library/provider/relevant_categories_provider.dart';
import 'package:chapturn/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/library_provider.dart';

class LibraryHead extends ConsumerStatefulWidget {
  const LibraryHead({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _LibraryHeadState createState() => _LibraryHeadState();
}

class _LibraryHeadState extends ConsumerState<LibraryHead>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final length = ref.read(relevantCategoriesProvider).length;
    if (length > 1) {
      _controller = TabController(
          length: ref.read(relevantCategoriesProvider).length, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final library = ref.watch(relevantCategoriesProvider);
    final destinationAnimation = ref.watch(destinationAnimationProvider);

    ref.listen<int>(
      relevantCategoriesProvider.select((library) => library.length),
      (previous, next) {
        assert(previous != next);
        _controller?.dispose();
        if (next > 1) {
          _controller = TabController(length: next, vsync: this);
        } else {
          _controller = null;
        }
      },
    );

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text('Library'),
          floating: true,
          forceElevated: innerBoxIsScrolled,
          bottom: library.length > 1
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(kTabHeight),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: _controller,
                      tabs: library
                          .map((category) => Tab(text: category.name))
                          .toList(),
                      isScrollable: true,
                    ),
                  ),
                )
              : null,
        ),
      ],
      body: FadeTransition(
        opacity: destinationAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
