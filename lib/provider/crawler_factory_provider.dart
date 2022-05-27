import 'package:nacht/domain/services/source_service.dart';
import 'package:nacht_sources/nacht_sources.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final crawlerFactoryProvider =
    Provider.autoDispose.family<Option<CrawlerFactory>, String>(
  (ref, url) {
    return ref.watch(sourceServiceProvider).crawlerFactoryFor(url: url);
  },
  name: 'CrawlerFactoryProvider',
);
