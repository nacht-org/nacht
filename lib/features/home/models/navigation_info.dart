import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_info.freezed.dart';

@freezed
class NavigationInfo with _$NavigationInfo {
  const factory NavigationInfo({
    required bool forceHide,
  }) = _NavigationInfo;

  const NavigationInfo._();
}
