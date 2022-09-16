import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final novelFamily = StateNotifierProvider.autoDispose
    .family<NovelNotifier, NovelData, NovelInput>(
  (ref, data) => NovelNotifier(
    read: ref.read,
    state: data.novel,
    fetchNovel: ref.watch(fetchNovelProvider),
    getNovelById: ref.watch(getNovelByIdProvider),
    getNovelCategoryMap: ref.watch(getNovelCategoryMapProvider),
    changeNovelCategories: ref.watch(changeNovelCategoriesProvider),
    getFirstUnreadChapter: ref.watch(getFirstUnreadChapterProvider),
  ),
  name: 'NovelProvider',
);

class NovelInput extends Equatable {
  const NovelInput(this.novel);

  final NovelData novel;

  @override
  List<Object?> get props => [novel.id];
}

class NovelNotifier extends StateNotifier<NovelData> with LoggerMixin {
  NovelNotifier({
    required Reader read,
    required NovelData state,
    required FetchNovel fetchNovel,
    required GetNovelById getNovelById,
    required GetNovelCategoryMap getNovelCategoryMap,
    required ChangeNovelCategories changeNovelCategories,
    required GetFirstUnreadChapter getFirstUnreadChapter,
  })  : _read = read,
        _fetchNovel = fetchNovel,
        _getNovelById = getNovelById,
        _getNovelCategoryMap = getNovelCategoryMap,
        _changeNovelCategories = changeNovelCategories,
        _getFirstUnreadChapter = getFirstUnreadChapter,
        super(state);

  final Reader _read;

  final FetchNovel _fetchNovel;
  final GetNovelById _getNovelById;
  final GetNovelCategoryMap _getNovelCategoryMap;
  final ChangeNovelCategories _changeNovelCategories;
  final GetFirstUnreadChapter _getFirstUnreadChapter;

  Future<void> fetch(CrawlerInfo? crawler) async {
    if (crawler == null) {
      _read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    final failure =
        (await _fetchNovel.execute(crawler.isolate, state.url)).toNullable();

    // TODO: add error to partial view
    if (failure != null) {
      log.warning(failure);
      _read(messageServiceProvider).showText(failure.message);
      return;
    }

    final result = await _getNovelById.execute(state.id);
    result.fold(
      (failure) {
        log.warning(failure);
        _read(messageServiceProvider).showText(failure.message);
      },
      (data) {
        state = data;

        // Chapter list may be changed after updating the novel from source.
        // So reload if chapter list has been previously loaded.
        final chapterList = _read(chapterListFamily(state.id));
        if (chapterList.isLoaded) {
          _read(chapterListFamily(state.id).notifier).reload();
        }
      },
    );
  }

  Future<void> toggleLibrary() async {
    Map<CategoryData, bool>? categories =
        await _getNovelCategoryMap.execute(state.id);

    // There must always be one category.
    assert(categories.isNotEmpty);

    if (categories.length == 1) {
      // if there is only one category (default) dont show the dialog
      // just reverse the state.
      categories = {
        for (final entry in categories.entries) entry.key: !entry.value
      };
    } else {
      categories = await _read(dialogServiceProvider).show<CategorySelection?>(
        child: SetCategoriesDialog(categories: categories),
      );
    }

    // Dont do anything if the dialog was cancelled.
    if (categories == null) {
      return;
    }

    final result = await _changeNovelCategories.execute(state, categories);
    result.fold((failure) {
      log.warning(failure);
    }, (data) {
      state = state.copyWith(favourite: data);
    });
  }

  Future<void> reload() async {
    final result = await _getNovelById.execute(state.id);

    result.fold(
      (failure) => log.warning(failure),
      (data) => state = data,
    );
  }

  Future<void> readFirstUnread() async {
    final unread = await _getFirstUnreadChapter.execute(state.id);

    unread.fold(
      (failure) => _read(messageServiceProvider).showText(failure.message),
      (data) => _read(routerProvider).push(
        ReaderRoute(novel: state, chapter: data),
      ),
    );
  }
}
