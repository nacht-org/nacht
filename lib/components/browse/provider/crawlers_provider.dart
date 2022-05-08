import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/domain.dart';

final crawlersProvider = Provider<List<CrawlerFactory>>((ref) {
  final sourceService = ref.watch(sourceServiceProvider);

  return sourceService.crawlers().fold((failure) => [], (data) => data);
});
