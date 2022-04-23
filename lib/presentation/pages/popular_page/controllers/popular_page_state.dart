import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/entities/entities.dart';

part 'popular_page_state.freezed.dart';

@freezed
class PopularPageState with _$PopularPageState {
  const factory PopularPageState.loading() = _PopularPageLoading;
  const factory PopularPageState.unsupported() = _PopularNovelUnsupported;
  const factory PopularPageState.data(List<PartialNovelEntity> entities) =
      _PopularNovelData;
}

class PopularPageController extends StateNotifier<PopularPageState> {
  List<PartialNovelEntity> _novels = [];

  PopularPageController(super.state);

  void add(List<PartialNovelEntity> novels) {
    _novels = [..._novels, ...novels];
    state = PopularPageState.data(_novels);
  }
}
