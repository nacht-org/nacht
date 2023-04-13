import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

import '../notifications/notifications.dart';
import '../services/services.dart';

class AppUpdateCheckTask extends BackgroundTask<void> with LoggerMixin {
  static const String name = 'AppUpdateCheckTask';

  @override
  Future<bool> execute(ProviderContainer container, void data) async {
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
