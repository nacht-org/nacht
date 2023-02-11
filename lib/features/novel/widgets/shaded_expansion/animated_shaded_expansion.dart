import 'package:flutter/material.dart';

import 'shaded_expansion_transition.dart';

class AnimatedShadedExpansion extends StatefulWidget {
  const AnimatedShadedExpansion({
    super.key,
    required this.open,
    required this.child,
    required this.duration,
    this.minimumHeight = 50,
    this.curve = Curves.easeInOut,
  });

  final bool open;
  final double minimumHeight;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<AnimatedShadedExpansion> createState() =>
      _AnimatedShadedExpansionState();
}

class _AnimatedShadedExpansionState extends State<AnimatedShadedExpansion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.open ? 1.0 : 0.0,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedShadedExpansion oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.open != oldWidget.open) {
      widget.open ? _controller.forward() : _controller.reverse();
    }

    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }

    if (widget.curve != oldWidget.curve) {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadedExpansionTransition(
      animation: _animation,
      minimumHeight: widget.minimumHeight,
      child: widget.child,
    );
  }
}
