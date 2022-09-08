import 'package:flutter_test/flutter_test.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/database/database.dart';

void main() {
  final tChapter = Chapter(
    id: 2,
    chapterIndex: 2,
    title: 'my chapter',
    content: null,
    url: 'https://website.com/novel/123/1',
    updated: DateTime(2022, 4, 23),
    readAt: DateTime(2022, 5, 25),
    novelId: 1,
    volumeId: 2,
  );

  final tVolume = VolumeData(id: 2, index: 1, name: "v1", novelId: 1);
  final tData = ChapterData(
    id: 2,
    index: 2,
    title: 'my chapter',
    content: null,
    url: 'https://website.com/novel/123/1',
    updated: DateTime(2022, 4, 23),
    readAt: DateTime(2022, 5, 25),
    novelId: 1,
    volume: tVolume,
  );

  test('should create chapter data from data.chapter', () {
    final result = ChapterData.fromModel(tChapter, tVolume);
    expect(result, tData);
  });
}
