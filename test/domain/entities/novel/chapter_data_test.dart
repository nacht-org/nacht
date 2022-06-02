import 'package:nacht/data/data.dart';
import 'package:nacht/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final tVolumeData = VolumeData(
    id: 2,
    index: 1,
    name: '',
    novelId: 1,
  );

  final tData = ChapterData(
    id: 2,
    index: 2,
    title: 'my chapter',
    content: null,
    url: 'https://website.com/novel/123/1',
    updated: DateTime(2022, 4, 23),
    readAt: DateTime(2022, 5, 25),
    novelId: 1,
    volume: tVolumeData,
  );

  test('should create chapter data from data.chapter', () {
    final result = ChapterData.fromModel(tChapter, tVolumeData);
    expect(result, tData);
  });
}
