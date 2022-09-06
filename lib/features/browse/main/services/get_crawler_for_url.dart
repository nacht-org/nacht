import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

final getCrawlerForUrlProvider = Provider<GetCrawlerForUrl>(
  (ref) => GetCrawlerForUrl(),
  name: 'GetCrawlerForUrlProvider',
);

class GetCrawlerForUrl {
  sources.CrawlerFactory? execute(String url) {
    return sources.crawlerFactoryFor(url);
  }
}
