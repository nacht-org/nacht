import 'package:chapturn/components/reader/provider/chapter_provider.dart';
import 'package:chapturn/components/reader/widgets/reader_body.dart';
import 'package:chapturn/provider/crawler_factory_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/domain.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({
    Key? key,
    required this.novel,
    required this.chapter,
  }) : super(key: key);

  final NovelData novel;
  final ChapterData chapter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              novel.title,
              style: theme.textTheme.titleLarge,
              maxLines: 1,
            ),
            Text(
              chapter.title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.hintColor,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: Consumer(
        builder: (context, ref, child) {
          final crawlerFactory = ref.watch(crawlerFactoryProvider(novel.url));

          return crawlerFactory.fold(
            () => Center(
              child: Text('uh oh.'),
            ),
            (data) => ReaderBody(
              novel: novel,
              chapter: chapter,
              crawlerFactory: data,
            ),
          );
        },
      ),
      extendBody: true,
    );
  }
}
