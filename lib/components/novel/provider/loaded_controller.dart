import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/novel/novel_data.dart';
import '../../../../domain/usecases/category/change_novel_categories.dart';
import '../../../../domain/usecases/category/get_all_categories.dart';
import '../../../../domain/usecases/novel/download_novel_cover.dart';
import '../../../../domain/usecases/novel/get_novel.dart';
import '../../../../domain/usecases/novel/parse_or_get_novel.dart';
import '../../library/provider/library_provider.dart';
import 'novel_page_notice.dart';
import 'providers.dart';

class LoadedController extends StateNotifier<NovelData> with LoggerMixin {
  LoadedController(
    NovelData state, {
    required this.crawler,
    required this.read,
    required this.getNovel,
    required this.parseOrGetNovel,
    required this.downloadNovelCover,
    required this.getAllCategories,
    required this.changeNovelCategories,
  }) : super(state);

  final Reader read;
  final Crawler? crawler;

  final GetNovel getNovel;
  final ParseOrGetNovel parseOrGetNovel;
  final DownloadNovelCover downloadNovelCover;
  final GetAllCategories getAllCategories;
  final ChangeNovelCategories changeNovelCategories;

  NoticeController get _notice => read(noticeProvider.notifier);
  LibraryController get _library => read(libraryProvider.notifier);

  Future<void> fetch() async {
    if (crawler == null || crawler is! ParseNovel) {
      _notice.error('Unable to parse.');
      return;
    }

    log.info('Start parse or get novel.');
    final result =
        await parseOrGetNovel.execute(crawler as ParseNovel, state.url);
    log.info('End parse or get novel.');

    result.fold(
      (failure) => _notice.error('An error occured'),
      (data) async {
        state = data;

        log.info('Downloading cover.');
        final coverResult = await downloadNovelCover.execute(state);
        coverResult.fold(
          (failure) {
            log.warning(failure.toString());
          },
          (data) => state = state.copyWith(cover: data),
        );
      },
    );
  }

  Future<void> addToLibrary() async {
    final categories = await getAllCategories.execute();
    final map = {for (final category in categories) category: true};

    await changeNovelCategories.execute(state, map);

    state = state.copyWith(
      favourite: true,
    );

    _library.reload();
  }

  Future<void> removeFromLibrary() async {
    final categories = await getAllCategories.execute();
    final map = {for (final category in categories) category: false};

    await changeNovelCategories.execute(state, map);

    state = state.copyWith(
      favourite: false,
    );

    _library.reload();
  }

  Future<void> reload() async {
    final result = await getNovel.execute(state.id);

    result.fold(
      (failure) => {},
      (data) => state = data,
    );
  }
}
