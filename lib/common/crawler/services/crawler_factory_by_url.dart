import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final crawlerFactoryByUrlProvider = Provider<CrawlerFactoryByUrl>(
  (ref) => CrawlerFactoryByUrl(),
  name: 'CrawlerFactoryByUrl',
);

/// Retrieve the crawler factory for the given url
class CrawlerFactoryByUrl {
  sources.CrawlerFactory? execute(String url) {
    return sources.crawlerFactoryFor(url);
  }
}
