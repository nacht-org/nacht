import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/usecases/category/change_novel_categories.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories.dart';
import 'package:chapturn/domain/usecases/parse_or_get_novel.dart';
import 'package:chapturn/presentation/controllers/library/library_controller.dart';
import 'package:chapturn/presentation/controllers/library/library_provider.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/novel_page_notice.dart';
import 'package:chapturn/presentation/pages/novel_page/providers/providers.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

class LoadedController extends StateNotifier<NovelEntity> {
  LoadedController(
    NovelEntity state, {
    required this.crawler,
    required this.read,
    required this.parseOrGetNovel,
    required this.getAllCategories,
    required this.changeNovelCategories,
  }) : super(state);

  final Reader read;
  final Crawler? crawler;

  final ParseOrGetNovel parseOrGetNovel;
  final GetAllCategories getAllCategories;
  final ChangeNovelCategories changeNovelCategories;

  final _log = Logger('LoadedController');

  NoticeController get _notice => read(noticeProvider.notifier);
  LibraryController get _library => read(libraryProvider.notifier);

  Future<void> reload() async {
    if (crawler == null || crawler is! ParseNovel) {
      _notice.error('Unable to parse.');
      return;
    }

    _log.info('Start parse or get novel.');
    final result =
        await parseOrGetNovel.execute(crawler as ParseNovel, state.url);
    _log.info('End parse or get novel.');

    result.fold(
      (failure) => _notice.error('An error occured'),
      (data) => state = data,
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
}
