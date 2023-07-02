import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:riverpod/riverpod.dart';

import 'check_new_release.dart';

final checkNewReleaseAndRouteProvider = Provider.autoDispose(
  (ref) => CheckNewReleaseAndRoute(
    ref: ref,
    checkNewRelease: ref.watch(checkNewReleaseProvider),
  ),
);

class CheckNewReleaseAndRoute {
  const CheckNewReleaseAndRoute({
    required Ref ref,
    required CheckNewRelease checkNewRelease,
  })  : _ref = ref,
        _checkNewRelease = checkNewRelease;

  final Ref _ref;
  final CheckNewRelease _checkNewRelease;

  Future<bool> call({bool silent = false}) async {
    final messageService = _ref.read(messageServiceProvider);

    // Only continue if there is an internet connection
    final isConnectionAvailable =
        await _ref.read(getIsConnectionAvailableProvider).execute();
    if (!isConnectionAvailable) {
      if (!silent) {
        messageService.showToast(const NoNetworkConnection().message);
      }
      return true;
    }

    if (!silent) {
      messageService.showToast("Searching for updates...");
    }
    final result = await _checkNewRelease.call();

    result.fold(
      (failure) {
        if (!silent) {
          messageService.showToast(failure.message);
        }
      },
      (release) {
        if (release != null) {
          _ref.read(routerProvider).push(NewReleaseRoute(release: release));
        } else {
          if (!silent) {
            messageService.showToast("No new updates available");
          }
        }
      },
    );

    return result.isRight();
  }
}
