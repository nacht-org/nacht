import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'fetch_info.freezed.dart';

@freezed
class FetchInfo with _$FetchInfo {
  const factory FetchInfo({
    required List<PartialNovelData> data,
    required bool isLoading,
    required int page,
  }) = _PopularInfo;

  factory FetchInfo.initial() {
    return const FetchInfo(
      data: [],
      isLoading: false,
      page: 1,
    );
  }

  bool get isInitial => !isLoading && page == 1;
  bool get isInitialLoading => isLoading && page == 1;

  const FetchInfo._();
}
