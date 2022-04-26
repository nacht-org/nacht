import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/usecases/category/change_novel_categories.dart';
import 'package:chapturn/domain/usecases/category/get_all_categories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadedController extends StateNotifier<NovelEntity> {
  LoadedController(
    NovelEntity state, {
    required this.getAllCategories,
    required this.changeNovelCategories,
  }) : super(state);

  final GetAllCategories getAllCategories;
  final ChangeNovelCategories changeNovelCategories;

  Future<void> addToLibrary() async {
    final categories = await getAllCategories.execute();
    final map = {for (final category in categories) category: true};

    await changeNovelCategories.execute(state, map);

    state = state.copyWith(
      favourite: true,
    );
  }

  Future<void> removeFromLibrary() async {
    final categories = await getAllCategories.execute();
    final map = {for (final category in categories) category: false};

    await changeNovelCategories.execute(state, map);

    state = state.copyWith(
      favourite: false,
    );
  }
}
