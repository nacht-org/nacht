import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/entities/partial_novel_entity.dart';

typedef PopularPageState = List<PartialNovelEntity>;

class PopularPageController extends StateNotifier<PopularPageState> {
  PopularPageController(super.state);

  void add(PopularPageState entities) {
    state = [...state, ...entities];
  }
}
