import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final getCrawlersProvider = Provider<GetCrawlers>((ref) => GetCrawlers());

class GetCrawlers {
  List<CrawlerFactory> execute() {
    return sources.crawlers;
  }
}
