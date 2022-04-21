import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../config/routes/app_router.dart';
import '../../domain/entities/partial_novel_entity.dart';

class NovelGridCard extends StatelessWidget {
  const NovelGridCard({
    Key? key,
    required this.novel,
  }) : super(key: key);

  final PartialNovelEntity novel;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(NovelRoute(novel: novel)),
        child: Stack(
          children: [
            if (novel.thumbnailUrl != null)
              SizedBox.expand(
                child: Ink.image(
                  image: NetworkImage(novel.thumbnailUrl!),
                  fit: BoxFit.fill,
                ),
              ),
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  novel.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              bottom: 0,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
