import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';

class ShadedExpansionTransition extends StatelessWidget {
  const ShadedExpansionTransition({
    super.key,
    required this.animation,
    required this.child,
    required this.minimumHeight,
  });

  final Animation<double> animation;
  final Widget child;
  final double minimumHeight;

  @override
  Widget build(BuildContext context) {
    return CustomBoxy(
      delegate: ExpansionDelegate(
        animation: animation,
        child: child,
        minimumHeight: minimumHeight,
      ),
      children: [
        BoxyId(id: #first, child: child),
      ],
    );
  }
}

class ExpansionInner extends StatelessWidget {
  const ExpansionInner({
    super.key,
    required this.size,
    required this.child,
    required this.animation,
    required this.minimumHeight,
  });

  final Size size;
  final Widget child;
  final Animation<double> animation;
  final double minimumHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRect(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  final tween = Tween(begin: minimumHeight, end: size.height);

                  return SizedOverflowBox(
                    size: Size.fromHeight(tween.evaluate(animation)),
                    alignment: AlignmentDirectional.topCenter,
                    child: child!,
                  );
                },
                child: child,
              ),
            ),
            SizeTransition(
              sizeFactor: animation,
              child: const SizedBox(height: 24),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).canvasColor,
                  Theme.of(context).canvasColor.withOpacity(0),
                ],
              ),
            ),
            height: 24,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final radius = Tween<double>(begin: 0.8, end: 0);
                final scale = Tween<double>(begin: 1, end: -1);

                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: radius.evaluate(animation),
                      colors: [
                        Theme.of(context).canvasColor,
                        Theme.of(context).canvasColor.withOpacity(0),
                      ],
                    ),
                  ),
                  child: Transform.scale(
                    scaleY: scale.evaluate(animation),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ExpansionDelegate extends BoxyDelegate {
  ExpansionDelegate({
    super.relayout,
    super.repaint,
    required this.animation,
    required this.child,
    required this.minimumHeight,
  });

  final Animation<double> animation;
  final Widget child;
  final double minimumHeight;

  @override
  Size layout() {
    final firstChild = getChild(#first);
    final firstSize = firstChild.layout(constraints);

    if (firstSize.height >= minimumHeight) {
      firstChild.ignore();
      final secondChild = inflate(
        ExpansionInner(
          animation: animation,
          size: firstSize,
          minimumHeight: minimumHeight,
          child: child,
        ),
      );

      return secondChild.layout(constraints);
    } else {
      return firstSize;
    }
  }
}
