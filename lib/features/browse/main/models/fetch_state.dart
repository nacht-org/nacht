import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/features/features.dart';

part 'fetch_state.freezed.dart';

@freezed
class FetchState with _$FetchState {
  const factory FetchState.loading() = _Fetching;
  const factory FetchState.unsupported(String message) = _Unsupported;
  const factory FetchState.empty() = _Empty;
  const factory FetchState.data(List<PartialNovelData> entities) = _FetchData;
  const factory FetchState.error(String message) = _Error;

  bool get hasData => maybeWhen(data: (_) => true, orElse: () => false);

  const FetchState._();
}
