import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

void main() {
  test('should convert sources.Novel into NovelsCompanion', () {
    final tSource = sources.Novel(
      title: 'my novel',
      description: ['in', 'many', 'words'],
      author: 'my name',
      url: 'https://website.com/novel/123',
      thumbnailUrl: 'https://website.com/novel/123/cover.jpg',
      lang: 'en',
      status: sources.NovelStatus.ongoing,
      workType: const sources.OriginalWork(),
      readingDirection: sources.ReadingDirection.ltr,
    );

    const tCompanion = NovelsCompanion(
      title: Value('my novel'),
      description: Value('in\nmany\nwords'),
      author: Value('my name'),
      url: Value('https://website.com/novel/123'),
      coverUrl: Value('https://website.com/novel/123/cover.jpg'),
      lang: Value('en'),
      statusId: Value(StatusSeed.ongoing),
      workTypeId: Value(WorkTypeSeed.original),
      readingDirectionId: Value(ReadingDirectionSeed.ltr),
    );

    final result = sourceNovelIntoCompanion(tSource);
    expect(result, tCompanion);
  });
}
