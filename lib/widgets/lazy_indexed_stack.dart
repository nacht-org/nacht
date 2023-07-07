import 'package:flutter/material.dart';

typedef DestinationBuilder = Widget Function(BuildContext context);
typedef ChildBuilder = Widget Function(
    BuildContext context, Widget child, Animation<double> animation);

class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    Key? key,
    required this.initialIndex,
    required this.currentIndex,
    required this.builder,
    required this.destinations,
    required this.duration,
    this.curve = Curves.ease,
  }) : super(key: key);

  final int initialIndex;
  final ChildBuilder builder;
  final List<DestinationBuilder> destinations;
  final int currentIndex;
  final Duration duration;
  final Curve curve;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack>
    with SingleTickerProviderStateMixin {
  late int _index;

  final _dummyWidget = const SizedBox.shrink();
  final _initializedPagesTracker = <int, bool>{};

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _initializedPagesTracker[_index] = true;

    _animationController =
        AnimationController(vsync: this, value: 1.0, duration: widget.duration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentIndex != widget.currentIndex) {
      _index = widget.currentIndex;
      _initializedPagesTracker[_index] = true;
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = IndexedStack(
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

    return widget.builder(context, child, _animation);
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
