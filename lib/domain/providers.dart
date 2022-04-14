import 'package:chapturn/data/repositories/crawler_repository_impl.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn/domain/usecases/get_all_crawlers.dart';
import 'package:chapturn/domain/usecases/get_crawler_factory_for.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final crawlerRepository =
    Provider<CrawlerRepository>((ref) => CrawlerRepositoryImpl());

final getAllCrawlers = Provider<GetAllCrawlers>(
    (ref) => GetAllCrawlers(ref.watch(crawlerRepository)));

final getCrawlerFactoryFor = Provider<GetCrawlerFactoryFor>(
    (ref) => GetCrawlerFactoryFor(ref.watch(crawlerRepository)));
