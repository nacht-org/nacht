import 'package:nacht/common/common.dart';
import 'package:nacht_sources/nacht_sources.dart';

final helperNovelEntity = NovelData(
  id: 1,
  title: 'My novel story',
  url: 'https://website.com/novel/123',
  author: 'My',
  description: [],
  coverUrl: 'https://assets.website.com/novel/123/cover.jpg',
  status: NovelStatus.unknown,
  lang: 'en',
  chapters: [],
  metadata: [],
  workType: const OriginalWork(),
  readingDirection: ReadingDirection.ltr,
  favourite: false,
);
