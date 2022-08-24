import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nacht/shared/shared.dart';

class NovelGridCard extends StatelessWidget {
  const NovelGridCard({
    Key? key,
    required this.title,
    this.coverUrl,
    this.cover,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String? coverUrl;
  final AssetData? cover;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            if (image != null)
              SizedBox.expand(
                child: Ink.image(
                  image: image,
                  fit: BoxFit.fill,
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
                padding: const EdgeInsets.all(8.0).copyWith(top: 32.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
