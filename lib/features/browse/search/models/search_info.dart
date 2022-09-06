import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/shared/shared.dart';

part 'search_info.freezed.dart';

@freezed
class SearchInfo with _$SearchInfo {
  const factory SearchInfo.loading() = _SearchLoading;
  const factory SearchInfo.unsupported() = _SearchUnsupported;
  const factory SearchInfo.data(List<PartialNovelData> entities) = _SearchData;
}
