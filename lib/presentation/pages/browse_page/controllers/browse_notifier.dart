import 'package:chapturn/domain/providers/providers.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final availableCrawlers = Provider<List<CrawlerFactory>>((ref) {
  final crawlers = ref.watch(getAllCrawlers).execute();
  return crawlers.fold((failure) => [], (data) => data);
});
