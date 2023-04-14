import 'package:nacht/core/core.dart';
import 'package:nacht/features/release/background_tasks/background_tasks.dart';
import 'package:workmanager/workmanager.dart';
import 'package:riverpod/riverpod.dart';

abstract class BackgroundTask<T> {
  Future<bool> call(
    ProviderContainer container,
    Map<String, dynamic>? inputData,
  ) {
    return execute(container, parseInput(inputData));
  }

  T parseInput(Map<String, dynamic>? inputData);
  Future<bool> execute(ProviderContainer container, T data);
}

@pragma('vm:entry-point')
void onBackgroundTask() {
  Workmanager().executeTask((taskName, inputData) async {
    final container = ProviderContainer();
    await initializeLocalNotificationsPlugin();
    initializeLogger();

    try {
      switch (taskName) {
        case AppUpdateCheckTask.name:
          return AppUpdateCheckTask().call(container, inputData);
        case AppUpdateDownloadTask.name:
          return AppUpdateDownloadTask().call(container, inputData);
        default:
          return Future.value(true);
      }
    } catch (e) {
      return Future.error(e);
    }
  });
}

abstract class BackgroundTaskTag {
  static const String appUpdate = 'appUpdate';
}