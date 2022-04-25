import 'package:chapturn/domain/mapper.dart';
import 'package:chapturn/domain/repositories/category_repository.dart';
import 'package:chapturn/domain/repositories/crawler_repository.dart';
import 'package:chapturn/domain/repositories/network_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CrawlerRepository,
  ParseNovel,
  ParsePopular,
  NovelRemoteRepository,
  NovelLocalRepository,
  NetworkRepository,
  CategoryRepository,
])
void main() {}
