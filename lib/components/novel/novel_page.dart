import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/novel_page_args.dart';
import 'provider/providers.dart';
import 'widgets/intermediate.dart';

export 'model/novel_page_args.dart';

class NovelPage extends StatelessWidget {
  const NovelPage({
    Key? key,
    required this.novel,
    required this.crawler,
  }) : super(key: key);

  final NovelEntityArgument novel;
  final Crawler? crawler;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        novelArgProvider.overrideWithValue(novel),
        crawlerArgProvider.overrideWithValue(crawler),
      ],
      child: const Scaffold(
        body: Intermediate(),
      ),
    );
  }
}
