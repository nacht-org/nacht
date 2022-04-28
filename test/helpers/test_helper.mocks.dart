// Mocks generated by Mockito 5.1.0 from annotations
// in chapturn/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:chapturn/core/failure.dart' as _i5;
import 'package:chapturn/data/datasources/local/database.dart' as _i13;
import 'package:chapturn/domain/entities/entities.dart' as _i7;
import 'package:chapturn/domain/entities/network/network_connection.dart'
    as _i10;
import 'package:chapturn/domain/repositories/asset_repository.dart' as _i12;
import 'package:chapturn/domain/repositories/category_repository.dart' as _i11;
import 'package:chapturn/domain/repositories/crawler_repository.dart' as _i4;
import 'package:chapturn/domain/repositories/network_repository.dart' as _i9;
import 'package:chapturn/domain/repositories/novel_repository.dart' as _i8;
import 'package:chapturn_sources/chapturn_sources.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeNovel_1 extends _i1.Fake implements _i3.Novel {}

/// A class which mocks [CrawlerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrawlerRepository extends _i1.Mock implements _i4.CrawlerRepository {
  MockCrawlerRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i5.Failure, _i3.CrawlerFactory> crawlerFactoryFor(String? url) =>
      (super.noSuchMethod(Invocation.method(#crawlerFactoryFor, [url]),
              returnValue: _FakeEither_0<_i5.Failure, _i3.CrawlerFactory>())
          as _i2.Either<_i5.Failure, _i3.CrawlerFactory>);
  @override
  _i2.Either<_i5.Failure, List<_i3.CrawlerFactory>> getAllCrawlers() =>
      (super.noSuchMethod(Invocation.method(#getAllCrawlers, []),
              returnValue:
                  _FakeEither_0<_i5.Failure, List<_i3.CrawlerFactory>>())
          as _i2.Either<_i5.Failure, List<_i3.CrawlerFactory>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, List<_i7.PartialNovelEntity>>>
      getPopularNovels(_i3.ParsePopular? parser, int? page) => (super.noSuchMethod(
          Invocation.method(#getPopularNovels, [parser, page]),
          returnValue: Future<
                  _i2.Either<_i5.Failure, List<_i7.PartialNovelEntity>>>.value(
              _FakeEither_0<_i5.Failure, List<_i7.PartialNovelEntity>>())) as _i6
          .Future<_i2.Either<_i5.Failure, List<_i7.PartialNovelEntity>>>);
}

/// A class which mocks [ParseNovel].
///
/// See the documentation for Mockito's code generation for more information.
class MockParseNovel extends _i1.Mock implements _i3.ParseNovel {
  MockParseNovel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Novel> parseNovel(String? url) =>
      (super.noSuchMethod(Invocation.method(#parseNovel, [url]),
              returnValue: Future<_i3.Novel>.value(_FakeNovel_1()))
          as _i6.Future<_i3.Novel>);
  @override
  _i6.Future<void> parseChapter(_i3.Chapter? chapter) =>
      (super.noSuchMethod(Invocation.method(#parseChapter, [chapter]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}

/// A class which mocks [ParsePopular].
///
/// See the documentation for Mockito's code generation for more information.
class MockParsePopular extends _i1.Mock implements _i3.ParsePopular {
  MockParsePopular() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i3.Novel>> parsePopular(int? page) =>
      (super.noSuchMethod(Invocation.method(#parsePopular, [page]),
              returnValue: Future<List<_i3.Novel>>.value(<_i3.Novel>[]))
          as _i6.Future<List<_i3.Novel>>);
}

/// A class which mocks [NovelRemoteRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNovelRemoteRepository extends _i1.Mock
    implements _i8.NovelRemoteRepository {
  MockNovelRemoteRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i5.Failure, _i3.Novel>> parseNovel(
          _i3.ParseNovel? parser, String? url) =>
      (super.noSuchMethod(Invocation.method(#parseNovel, [parser, url]),
              returnValue: Future<_i2.Either<_i5.Failure, _i3.Novel>>.value(
                  _FakeEither_0<_i5.Failure, _i3.Novel>()))
          as _i6.Future<_i2.Either<_i5.Failure, _i3.Novel>>);
}

/// A class which mocks [NovelLocalRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNovelLocalRepository extends _i1.Mock
    implements _i8.NovelLocalRepository {
  MockNovelLocalRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i5.Failure, _i7.NovelEntity>> getNovel(int? id) =>
      (super.noSuchMethod(Invocation.method(#getNovel, [id]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>.value(
              _FakeEither_0<_i5.Failure, _i7.NovelEntity>())) as _i6
          .Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, _i7.NovelEntity>> getNovelByUrl(
          String? url) =>
      (super.noSuchMethod(Invocation.method(#getNovelByUrl, [url]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>.value(
              _FakeEither_0<_i5.Failure, _i7.NovelEntity>())) as _i6
          .Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, _i7.NovelEntity>> saveNovel(
          _i3.Novel? novel) =>
      (super.noSuchMethod(Invocation.method(#saveNovel, [novel]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>.value(
              _FakeEither_0<_i5.Failure, _i7.NovelEntity>())) as _i6
          .Future<_i2.Either<_i5.Failure, _i7.NovelEntity>>);
  @override
  _i6.Future<void> setFavourite(int? novelId, bool? value) =>
      (super.noSuchMethod(Invocation.method(#setFavourite, [novelId, value]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> setCover(int? novelId, _i7.AssetEntity? asset) =>
      (super.noSuchMethod(Invocation.method(#setCover, [novelId, asset]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}

/// A class which mocks [NetworkRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkRepository extends _i1.Mock implements _i9.NetworkRepository {
  MockNetworkRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i10.NetworkConnection> getConnectionStatus() =>
      (super.noSuchMethod(Invocation.method(#getConnectionStatus, []),
              returnValue: Future<_i10.NetworkConnection>.value(
                  _i10.NetworkConnection.none))
          as _i6.Future<_i10.NetworkConnection>);
  @override
  _i6.Future<bool> isConnectionAvailable() =>
      (super.noSuchMethod(Invocation.method(#isConnectionAvailable, []),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
}

/// A class which mocks [CategoryRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoryRepository extends _i1.Mock
    implements _i11.CategoryRepository {
  MockCategoryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i7.CategoryEntity>> getAllCategories() =>
      (super.noSuchMethod(Invocation.method(#getAllCategories, []),
          returnValue: Future<List<_i7.CategoryEntity>>.value(
              <_i7.CategoryEntity>[])) as _i6.Future<List<_i7.CategoryEntity>>);
  @override
  _i6.Future<List<_i7.CategoryEntity>> getCategoriesOfNovel(
          _i7.NovelEntity? novel) =>
      (super.noSuchMethod(Invocation.method(#getCategoriesOfNovel, [novel]),
          returnValue: Future<List<_i7.CategoryEntity>>.value(
              <_i7.CategoryEntity>[])) as _i6.Future<List<_i7.CategoryEntity>>);
  @override
  _i6.Future<void> changeNovelCategories(
          _i7.NovelEntity? novel, Map<_i7.CategoryEntity, bool>? categories) =>
      (super.noSuchMethod(
          Invocation.method(#changeNovelCategories, [novel, categories]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<List<_i7.NovelEntity>> getNovelsOfCategory(
          _i7.CategoryEntity? category) =>
      (super.noSuchMethod(Invocation.method(#getNovelsOfCategory, [category]),
              returnValue:
                  Future<List<_i7.NovelEntity>>.value(<_i7.NovelEntity>[]))
          as _i6.Future<List<_i7.NovelEntity>>);
}

/// A class which mocks [AssetRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAssetRepository extends _i1.Mock implements _i12.AssetRepository {
  MockAssetRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i5.Failure, _i7.AssetEntity>> addAsset(
          _i13.AssetsCompanion? asset) =>
      (super.noSuchMethod(Invocation.method(#addAsset, [asset]),
          returnValue: Future<_i2.Either<_i5.Failure, _i7.AssetEntity>>.value(
              _FakeEither_0<_i5.Failure, _i7.AssetEntity>())) as _i6
          .Future<_i2.Either<_i5.Failure, _i7.AssetEntity>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, _i13.AssetsCompanion>> downloadAsset(
          String? url) =>
      (super.noSuchMethod(Invocation.method(#downloadAsset, [url]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, _i13.AssetsCompanion>>.value(
                      _FakeEither_0<_i5.Failure, _i13.AssetsCompanion>()))
          as _i6.Future<_i2.Either<_i5.Failure, _i13.AssetsCompanion>>);
  @override
  _i6.Future<_i2.Either<_i5.Failure, void>> deleteAsset(
          _i7.AssetEntity? asset) =>
      (super.noSuchMethod(Invocation.method(#deleteAsset, [asset]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i6.Future<_i2.Either<_i5.Failure, void>>);
}
