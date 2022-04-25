import 'package:chapturn/domain/entities/category/category_entity.dart';
import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InLibraryController extends StateNotifier<List<CategoryEntity>?> {
  InLibraryController({
    required List<CategoryEntity>? state,
    required this.novel,
  }) : super(state);

  final NovelEntity? novel;

  Future<void> fetch() async {
    if (novel == null) {
      return;
    }
  }

  Future<void> add() async {
    // get all categories

    // TODO: if there is more than one category, show a dialog
  }
}
