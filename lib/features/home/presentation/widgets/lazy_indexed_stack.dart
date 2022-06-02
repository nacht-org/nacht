import 'package:flutter/material.dart';

typedef DestinationBuilder = Widget Function(BuildContext context);
typedef ChildBuilder = Widget Function(BuildContext context, Widget child);

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    required this.initialIndex,
    required this.currentIndex,
    required this.builder,
    required this.destinations,
  }) : super(key: key);

  final int initialIndex;
  final ChildBuilder builder;
  final List<DestinationBuilder> destinations;
  final int currentIndex;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late int _index;

  final _dummyWidget = const SizedBox.shrink();
  final _initializedPagesTracker = <int, bool>{};

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _initializedPagesTracker[_index] = true;
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex) {
      _index = widget.currentIndex;
      _initializedPagesTracker[_index] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stack = IndexedStack(
      index: _index,
      sizing: StackFit.expand,
      children: List.generate(widget.destinations.length, (index) {
        final destination = widget.destinations[index];
        final initialized = _initializedPagesTracker[index] == true;

        return initialized
            ? _KeepAlive(builder: destination, maintainState: true)
            : _dummyWidget;
      }),
    );

    return widget.builder(context, stack);
  }
}

class _KeepAlive extends StatefulWidget {
  const _KeepAlive({
    Key? key,
    required this.builder,
    this.maintainState = true,
  }) : super(key: key);

  final DestinationBuilder builder;
  final bool maintainState;

  @override
  State<_KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context);
  }

  @override
  bool get wantKeepAlive => widget.maintainState;
}
