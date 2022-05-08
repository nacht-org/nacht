import 'package:chapturn/components/novel/widgets/novel_view.dart';
import 'package:chapturn/core/services/message_service.dart';
import 'package:chapturn/domain/services/library_service.dart';
import 'package:chapturn/domain/services/novel_service.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/novel/novel_data.dart';
import '../../library/provider/library_provider.dart';

final novelProvider =
    StateNotifierProvider.autoDispose<NovelNotifier, NovelData>(
  (ref) => NovelNotifier(
    read: ref.read,
    state: ref.watch(currentNovelProvider),
    crawler: ref.watch(currentCrawlerProvider),
    novelService: ref.watch(novelServiceProvider),
    libraryService: ref.watch(libraryServiceProvider),
  ),
  dependencies: [
    currentNovelProvider,
    currentCrawlerProvider,
    novelServiceProvider,
    libraryServiceProvider,
  ],
);

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

  LibraryNotifier get _library => read(libraryProvider.notifier);

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
      },
    );
  }

  Future<void> addToLibrary() async {
    final categories = await libraryService.categories();
    final map = {for (final category in categories) category: true};

    await libraryService.changeCategory(state, map);

    state = state.copyWith(
      favourite: true,
    );

    _library.reload();
  }

  Future<void> removeFromLibrary() async {
    final categories = await libraryService.categories();
    final map = {for (final category in categories) category: false};

    await libraryService.changeCategory(state, map);

    state = state.copyWith(
      favourite: false,
    );

    _library.reload();
  }

  Future<void> reload() async {
    final result = await novelService.getById(state.id);

    result.fold(
      (failure) => {},
      (data) => state = data,
    );
  }
}
