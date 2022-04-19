import 'package:chapturn/data/repositories/crawler_repository_impl.dart';
import 'package:chapturn/domain/providers/mapper_providers.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final crawlerRepository = Provider<CrawlerRepository>(
    (ref) => CrawlerRepositoryImpl(ref.watch(partialNovelSourceFromMapper)));
