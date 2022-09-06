import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tModel = Novel(
    id: 10,
    title: 'my novel',
    author: 'my name',
    coverUrl: 'https://website.com/novel/123/cover.jpg',
    coverId: 1,
    url: 'https://website.com/novel/123',
    description: 'first paragraph\nsecond paragraph',
    lang: 'en',
    readingDirectionId: ReadingDirectionSeed.ltr,
    workTypeId: WorkTypeSeed.translationMtl,
    statusId: StatusSeed.completed,
    favourite: true,
  );

  final tData = NovelData(
    id: 10,
    title: 'my novel',
    author: 'my name',
    coverUrl: 'https://website.com/novel/123/cover.jpg',
    url: 'https://website.com/novel/123',
    description: ['first paragraph', 'second paragraph'],
    lang: 'en',
    readingDirection: sources.ReadingDirection.ltr,
    workType: const sources.TranslatedWork.mtl(),
    status: sources.NovelStatus.completed,
    chapters: [],
    favourite: true,
  );

  test('should create NovelData from Novel', () {
    final result = NovelData.fromModel(tModel);
    expect(result, tData);
  });
}
