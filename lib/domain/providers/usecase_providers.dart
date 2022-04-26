import 'package:chapturn/domain/providers/repository_providers.dart';
import 'package:chapturn/domain/usecases/category/change_novel_categories.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories.dart';
import 'package:chapturn/domain/usecases/get_all_crawlers.dart';
import 'package:chapturn/domain/usecases/get_crawler_factory_for.dart';
import 'package:chapturn/domain/usecases/get_popular_novels.dart';
import 'package:chapturn/domain/usecases/parse_or_get_novel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getAllCrawlers = Provider<GetAllCrawlers>(
    (ref) => GetAllCrawlers(ref.watch(crawlerRepository)));

final getCrawlerFactoryFor = Provider<GetCrawlerFactoryFor>(
    (ref) => GetCrawlerFactoryFor(ref.watch(crawlerRepository)));

final getPopularNovels = Provider<GetPopularNovels>(
  (ref) => GetPopularNovels(crawlerRepository: ref.watch(crawlerRepository)),
);

final parseOrGetNovel = Provider<ParseOrGetNovel>(
  (ref) => ParseOrGetNovel(
    ref.watch(novelRemoteRepository),
    ref.watch(novelLocalRepository),
    ref.watch(networkRepository),
  ),
);

final getAllCategories = Provider<GetAllCategories>((ref) =>
    GetAllCategories(categoryRepository: ref.watch(categoryRepository)));

final changeNovelCategories = Provider<ChangeNovelCategories>(
  (ref) => ChangeNovelCategories(
    categoryRepository: ref.watch(categoryRepository),
    novelLocalRepository: ref.watch(novelLocalRepository),
  ),
);
