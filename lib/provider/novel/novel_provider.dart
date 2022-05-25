import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/category/set_categories/provider/selected_categories_provider.dart';
import '../../components/category/set_categories/set_categories_dialog.dart';
import '../../components/library/provider/library_provider.dart';
import '../../components/updates/provider/updates_provider.dart';
import '../../core/core.dart';
import '../../domain/domain.dart';

part 'novel_provider.freezed.dart';

final novelProvider = StateNotifierProvider.autoDispose
    .family<NovelNotifier, NovelData, NovelInput>(
  (ref, data) => NovelNotifier(
    read: ref.read,
    state: data.novel,
    crawler: data.crawler,
    novelService: ref.watch(novelServiceProvider),
    libraryService: ref.watch(libraryServiceProvider),
  ),
  name: 'NovelProvider',
);

@Freezed(equal: false)
class NovelInput extends Equatable with _$NovelInput {
  factory NovelInput(
    NovelData novel, [
    Crawler? crawler,
  ]) = _NovelInput;

  NovelInput._();

  @override
  List<Object?> get props => [novel.id];
}

class NovelNotifier extends StateNotifier<NovelData> with LoggerMixin {
  NovelNotifier({
    required this.read,
    required NovelData state,
    required this.crawler,
    required this.novelService,
    required this.libraryService,
  }) : super(state);

  final Reader read;
  final Crawler? crawler;

  final NovelService novelService;
  final LibraryService libraryService;

  Future<void> fetch() async {
    if (crawler == null || crawler is! ParseNovel) {
      read(messageServiceProvider).showText('Unable to parse.');
      return;
    }

    log.info('Start parse or get novel.');
    final result =
        await novelService.parseOrGet(crawler as ParseNovel, state.url);
    log.info('End parse or get novel.');

    result.fold(
      (failure) => read(messageServiceProvider).showText('An error occured'),
      (data) async {
        state = data;

        log.info('Downloading cover.');
        final coverResult = await novelService.downloadCover(state);
        coverResult.fold(
          (failure) {
            log.warning(failure.toString());
          },
          (data) => state = state.copyWith(cover: data),
        );

        read(updatesProvider.notifier).fetch();
      },
    );
  }

  Future<void> toggleLibrary() async {
    Map<CategoryData, bool>? categories =
        await libraryService.novelCategories(state);

    // There must always be one category.
    assert(categories.isNotEmpty);

    if (categories.length == 1) {
      // if there is only one category (default) dont show the dialog
      // just reverse the state.
      categories = {
        for (final entry in categories.entries) entry.key: !entry.value
      };
    } else {
      categories = await read(dialogServiceProvider).show<CategorySelection?>(
        child: SetCategoriesDialog(categories: categories),
      );
    }

    // Dont do anything if the dialog was cancelled.
    if (categories == null) {
      return;
    }

    final result = await libraryService.changeCategory(state, categories);
    result.fold((failure) {
      log.warning(failure);
    }, (data) {
      state = state.copyWith(favourite: data);
      read(libraryProvider.notifier).reload();
    });
  }

  Future<void> reload() async {
    final result = await novelService.getById(state.id);

    result.fold(
      (failure) => log.warning(failure),
      (data) => state = data,
    );
  }

  void setReadAt(int id, DateTime? readAt) {
    state = state.copyWith(volumes: [
      for (final volume in state.volumes)
        volume.copyWith(chapters: [
          for (final chapter in volume.chapters)
            if (chapter.id == id) chapter.copyWith(readAt: readAt) else chapter
        ])
    ]);
  }
}
