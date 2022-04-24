import 'package:auto_route/auto_route.dart';
import 'package:chapturn/presentation/pages/novel_page/novel_page.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../config/routes/app_router.dart';
import '../../domain/entities/entities.dart';

class NovelGridCard extends StatelessWidget {
  const NovelGridCard({
    Key? key,
    required this.novel,
    this.crawler,
  }) : super(key: key);

  final PartialNovelEntity novel;
  final Crawler? crawler;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.router.push(NovelRoute(
          novel: NovelEntityArgument.partial(novel),
          crawler: crawler,
        )),
        child: Stack(
          children: [
            if (novel.coverUrl != null)
              SizedBox.expand(
                child: Ink.image(
                  image: NetworkImage(novel.coverUrl!),
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
                      Color.fromARGB(100, 0, 0, 0),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0).copyWith(top: 12.0),
                child: Text(
                  novel.title,
                  style: Theme.of(context).textTheme.labelLarge,
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
