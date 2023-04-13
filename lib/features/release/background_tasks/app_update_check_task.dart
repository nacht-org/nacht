import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:riverpod/riverpod.dart';

import '../notifications/notifications.dart';
import '../services/services.dart';

class AppUpdateCheckTask extends BackgroundTask<void> with LoggerMixin {
  static const String name = 'AppUpdateCheck';

  @override
  Future<bool> execute(ProviderContainer container, void data) async {
    final isConnectionAvailable =
        await container.read(getIsConnectionAvailableProvider).execute();
    if (!isConnectionAvailable) {
      log.info('update check cancelled: no internet connection');
      return true;
    }

    final checkResult = await container.read(checkNewReleaseProvider).call();
    final value = checkResult.fold((failure) {
      log.warning(failure.toString());
      return false;
    }, (release) {
      if (release != null) {
        final notificationService = container.read(notificationServiceProvider);
        notificationService.show(NewUpdateNotification(release));
        log.info("found release in background");
      }
      return true;
    });

    return value;
  }

  @override
  void parseInput(Map<String, dynamic>? inputData) {}
}
