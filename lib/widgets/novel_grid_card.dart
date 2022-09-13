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
  }) : super(key: key);

  final String title;
  final String? coverUrl;
  final AssetData? cover;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ImageProvider? image;
    if (cover != null) {
      image = FileImage(cover!.file);
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
                child: Ink.image(
                  image: image,
                  fit: BoxFit.fill,
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
              child: AnimatedSwitcher(
                duration: kShortAnimationDuration,
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.fastOutSlowIn,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: selected
                    ? CircleAvatar(
                        key: const Key("avatar"),
                        radius: 16,
                        backgroundColor:
                            theme.colorScheme.secondary.withAlpha(200),
                        child: const Icon(
                          Icons.check,
                          size: 16,
                        ),
                      )
                    : null,
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
}
