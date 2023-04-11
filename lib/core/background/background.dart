import 'package:nacht/core/background/app_update_check.dart';
import 'package:workmanager/workmanager.dart';
import 'package:riverpod/riverpod.dart';

abstract class BackgroundTask {
  static const String appUpdateCheck = 'appUpdateCheck';
}

@pragma('vm:entry-point')
void background() {
  Workmanager().executeTask((taskName, inputData) {
    final container = ProviderContainer();

    try {
      switch (taskName) {
        case BackgroundTask.appUpdateCheck:
          return appUpdateCheck(container, inputData);
        default:
          return Future.value(true);
      }
    } catch (e) {
      return Future.error(e);
    }
  });
}
