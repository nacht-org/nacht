import 'package:flutter/material.dart';

class AnimationProvider extends InheritedWidget {
  const AnimationProvider({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key, child: child);

  final Animation<double> animation;

  // ignore: annotate_overrides, overridden_fields
  final Widget child;

  static AnimationProvider of(BuildContext context) {
    final instance =
        context.dependOnInheritedWidgetOfExactType<AnimationProvider>();
    assert(
      instance != null,
      "Inherited widget of type 'AnimationProvider' not found in the widget tree.\n",
    );

    return instance!;
  }

  @override
  bool updateShouldNotify(AnimationProvider oldWidget) {
    return oldWidget.animation != animation;
  }
}
