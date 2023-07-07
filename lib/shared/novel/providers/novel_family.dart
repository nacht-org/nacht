import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final novelFamily = StateNotifierProvider.autoDispose
    .family<NovelNotifier, NovelData, NovelInput>(
  (ref, data) => NovelNotifier(
    ref: ref,
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
    required Ref ref,
    required NovelData state,
    required FetchNovel fetchNovel,
    required GetNovelById getNovelById,
    required GetNovelCategoryMap getNovelCategoryMap,
    required ChangeNovelCategories changeNovelCategories,
    required GetFirstUnreadChapter getFirstUnreadChapter,
  })  : _ref = ref,
        _fetchNovel = fetchNovel,
        _getNovelById = getNovelById,
        _getNovelCategoryMap = getNovelCategoryMap,
        _changeNovelCategories = changeNovelCategories,
        _getFirstUnreadChapter = getFirstUnreadChapter,
        super(state);

  final Ref _ref;

  final FetchNovel _fetchNovel;
  final GetNovelById _getNovelById;
  final GetNovelCategoryMap _getNovelCategoryMap;
  final ChangeNovelCategories _changeNovelCategories;
  final GetFirstUnreadChapter _getFirstUnreadChapter;

  Future<void> fetch(CrawlerInfo? crawler) async {
    if (crawler == null) {
      _ref.read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    final failure =
        (await _fetchNovel.execute(crawler.isolate, state.url)).toNullable();

    // TODO: add error to partial view
    if (failure != null) {
      log.warning(failure);
      _ref.read(messageServiceProvider).showText(failure.message);
      return;
    }

    final result = await _getNovelById.execute(state.id);
    result.fold(
      (failure) {
        log.warning(failure);
        _ref.read(messageServiceProvider).showText(failure.message);
      },
      (data) {
        state = data;
      },
    );
  }

  Future<void> toggleLibrary() async {
    return state.favourite ? removeFromLibrary() : editCategories();
  }

  Future<void> editCategories() async {
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
      // Don't show default in category list unless it is selected
      categories = {
        for (final entry in categories.entries)
          if (entry.value == true || !entry.key.isDefault)
            entry.key: entry.value
      };

      categories =
          await _ref.read(dialogServiceProvider).show<CategorySelection?>(
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

  /// Remove novel from all categories
  Future<void> removeFromLibrary() async {
    Map<CategoryData, bool> categories =
        await _getNovelCategoryMap.execute(state.id);

    categories = {for (final entry in categories.entries) entry.key: false};

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
      (failure) => _ref.read(messageServiceProvider).showText(failure.message),
      (data) => _ref.read(routerProvider).push(
            ReaderRoute(novel: state, chapter: data),
          ),
    );
  }
}
