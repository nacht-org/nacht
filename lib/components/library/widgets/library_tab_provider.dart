import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tabControllerProvider = Provider<TabController?>(
  (ref) => throw UnimplementedError(),
);

class TabControllerProvider extends ConsumerStatefulWidget {
  const TabControllerProvider({
    Key? key,
    required this.child,
    required this.length,
  }) : super(key: key);

  final Widget child;
  final AlwaysAliveProviderBase<int> length;

  @override
  ConsumerState<TabControllerProvider> createState() =>
      _TabControllerProviderState();
}

class _TabControllerProviderState extends ConsumerState<TabControllerProvider>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();

    final length = ref.read(widget.length);
    if (length > 1) {
      _controller = TabController(
        length: ref.read(widget.length),
        vsync: this,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(widget.length, (previous, next) {
      assert(previous != next);

      _controller?.dispose();
      if (next > 1) {
        _controller = TabController(length: next, vsync: this);
      } else {
        _controller = null;
      }
    });

    return ProviderScope(
      overrides: [
        tabControllerProvider.overrideWithValue(_controller),
      ],
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
