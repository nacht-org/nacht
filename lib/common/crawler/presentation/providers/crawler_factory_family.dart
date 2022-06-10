import 'package:nacht/common/common.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final crawlerFactoryFamily =
    Provider.autoDispose.family<sources.CrawlerFactory?, String>(
  (ref, url) {
    return ref.watch(crawlerFactoryByUrlProvider).execute(url);
  },
  name: 'CrawlerFactoryProvider',
);
