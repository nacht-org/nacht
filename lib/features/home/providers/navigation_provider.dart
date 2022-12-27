import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationInfo>(
  (ref) => NavigationNotifier(
    state: const NavigationInfo(
      forceHide: false,
    ),
  ),
  name: "NavigationProvider",
);

class NavigationNotifier extends StateNotifier<NavigationInfo>
    with LoggerMixin {
  NavigationNotifier({
    required NavigationInfo state,
  }) : super(state);

  void setForceHide(bool forceHide) {
    state = state.copyWith(forceHide: forceHide);
    log.fine("Force hide navigation set to $forceHide");
  }

  /// Listen to the provided [provider] and hide bottom navigation bar when
  /// provider value is true.
  static void handleHide(WidgetRef ref, ProviderListenable<bool> provider) {
    ref.listen<bool>(provider, (previous, next) {
      previous ??= false;
      if (!previous && next) {
        // Turned on
        ref.read(navigationProvider.notifier).setForceHide(true);
      } else if (previous && !next) {
        // Turned off
        ref.read(navigationProvider.notifier).setForceHide(false);
      }
    });
  }
}
