import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';

final downloadChapterProvider = Provider<DownloadChapter>(
  (ref) => DownloadChapter(
    database: ref.watch(databaseProvider),
    fetchChapterContent: ref.watch(fetchChapterContentProvider),
  ),
  name: 'DownloadChapterProvider',
);

class DownloadChapter {
  const DownloadChapter({
    required FetchChapterContent fetchChapterContent,
    required AppDatabase database,
  })  : _fetchChapterContent = fetchChapterContent,
        _database = database;

  final FetchChapterContent _fetchChapterContent;
  final AppDatabase _database;

  Future<Either<Failure, AssetData>> call(
    sources.Meta meta,
    sources.CrawlerIsolate isolate,
    int novelId,
    int chapterId,
    String chapterUrl,
  ) async {
    final content = await _fetchChapterContent.execute(isolate, chapterUrl);

    return await content.fold(
      (failure) async => Left(failure),
      (content) async {
        final documentsDir = await getApplicationDocumentsDirectory();
        final filePath = path.join(documentsDir.path, 'novels', meta.id,
            novelId.toString(), '${chapterId.toString()}.html');

        final file = File(filePath);
        await file.parent.create(recursive: true);
        file.writeAsString(content);

        final hash = md5.convert(utf8.encode(content)).toString();

        final Asset asset;
        try {
          asset = await _database.transaction(() async {
            final asset =
                await _database.into(_database.assets).insertReturning(
                      AssetsCompanion(
                        hash: Value(hash),
                        url: Value(chapterUrl),
                        path: Value(filePath),
                        typeId: const Value(AssetTypeSeed.textHtml),
                        savedAt: Value(DateTime.now()),
                      ),
                    );

            await (_database.update(_database.chapters)
                  ..where((tbl) => tbl.id.equals(chapterId)))
                .write(ChaptersCompanion(content: Value(asset.id)));

            return asset;
          });
        } catch (e) {
          await file.delete();
          rethrow;
        }

        return Right(AssetData.fromModel(asset));
      },
    );
  }
}
