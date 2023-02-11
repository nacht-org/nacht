import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';

class NovelGridCard extends StatelessWidget {
  const NovelGridCard({
    Key? key,
    required this.title,
    this.coverUrl,
    this.cover,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.favourite = false,
  }) : super(key: key);

  final String title;
  final String? coverUrl;
  final AssetData? cover;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final bool selected;
  final bool favourite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ImageProvider? image;
    if (cover?.file != null) {
      image = FileImage(cover!.file!);
    } else if (coverUrl != null) {
      image = CachedNetworkImageProvider(coverUrl!);
    } else {
      image = null;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          children: [
            if (image != null)
              SizedBox.expand(
                child: AnimatedOpacityBuilder(
                  opacity: favourite ? 1 : 0,
                  duration: kShortAnimationDuration,
                  builder: (context, opacity) => Ink.image(
                    image: image!,
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(opacity),
                      BlendMode.saturation,
                    ),
                  ),
                ),
              ),
            Positioned.fill(
              child: AnimatedContainer(
                color:
                    theme.colorScheme.surfaceTint.withAlpha(selected ? 50 : 0),
                duration: kShortAnimationDuration,
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: buildAnimatedSwitcher(
                child: buildIndicator(theme),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(150, 0, 0, 0),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0).copyWith(top: 48.0),
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    shadows: const [
                      Shadow(blurRadius: 2.0),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedSwitcher({
    required Widget child,
  }) {
    return AnimatedSwitcher(
      duration: kShortAnimationDuration,
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: child,
    );
  }

  Widget buildIndicator(ThemeData theme) {
    if (favourite) {
      return CircleAvatar(
        key: const Key("favourite"),
        radius: 16,
        backgroundColor: theme.colorScheme.surface,
        child: const Icon(
          Icons.favorite,
          size: 16,
        ),
      );
    } else if (selected) {
      return CircleAvatar(
        key: const Key("selected"),
        radius: 16,
        backgroundColor: theme.colorScheme.surface,
        child: const Icon(
          Icons.check,
          size: 16,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class AnimatedOpacityBuilder extends ImplicitlyAnimatedWidget {
  const AnimatedOpacityBuilder({
    super.key,
    super.curve = Curves.fastOutSlowIn,
    required super.duration,
    required this.builder,
    required this.opacity,
  }) : assert(opacity >= 0.0 && opacity <= 1.0);

  final double opacity;

  final Widget Function(BuildContext context, double value) builder;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      AnimatedOpacityBuilderState();
}

class AnimatedOpacityBuilderState
    extends AnimatedWidgetBaseState<AnimatedOpacityBuilder> {
  Tween<double>? _opacity;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _opacity = visitor(_opacity, widget.opacity,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _opacity!.evaluate(animation),
    );
  }
}
