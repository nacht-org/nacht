import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/common/common.dart';

part 'fetch_info.freezed.dart';

@freezed
class FetchInfo with _$FetchInfo {
  const factory FetchInfo({
    required List<PartialNovelData> data,
    required bool isLoading,
    required int page,
    required String? error,
  }) = _PopularInfo;

  factory FetchInfo.initial() {
    return const FetchInfo(
      data: [],
      isLoading: false,
      page: 1,
      error: null,
    );
  }

  bool get isInitial => page == 1;

  const FetchInfo._();
}
