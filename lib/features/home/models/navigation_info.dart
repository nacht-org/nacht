import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_info.freezed.dart';

@freezed
class NavigationInfo with _$NavigationInfo {
  const factory NavigationInfo({
    required ScrollEvent event,
    required bool forceHide,
  }) = _NavigationInfo;

  const NavigationInfo._();
}

class ScrollEvent {
  const ScrollEvent.delta(this.delta) : isEnd = false;
  const ScrollEvent.end()
      : delta = 0,
        isEnd = true;

  final double delta;
  final bool isEnd;

  T when<T>({
    required T Function(double delta) delta,
    required T Function() end,
  }) {
    if (isEnd) {
      return end();
    } else {
      return delta(this.delta);
    }
  }
}
