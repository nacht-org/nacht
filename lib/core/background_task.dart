import 'package:nacht/core/core.dart';
import 'package:nacht/features/release/background_tasks/background_tasks.dart';
import 'package:workmanager/workmanager.dart';
import 'package:riverpod/riverpod.dart';

abstract class BackgroundTask<T> {
  const BackgroundTask();

  Future<bool> call(
    ProviderContainer container,
    Map<String, dynamic>? inputData,
  ) {
    return execute(container, parseInput(inputData));
  }

  T parseInput(Map<String, dynamic>? inputData);
  Future<bool> execute(ProviderContainer container, T data);
}

class BackgroundTaskId {
  const BackgroundTaskId(this.id, this.name, [this.tag]);

  final String id;
  final String name;
  final BackgroundTaskTag? tag;

  /// Register this task to be run in the background right now
  Future<void> registerOnce({
    final String? tag,
    final ExistingWorkPolicy? existingWorkPolicy,
    final Duration initialDelay = Duration.zero,
    final BackoffPolicy? backoffPolicy,
    final Map<String, dynamic>? inputData,
  }) {
    return Workmanager().registerOneOffTask(
      id,
      name,
      tag: tag ?? this.tag?.name,
      existingWorkPolicy: existingWorkPolicy,
      initialDelay: initialDelay,
      backoffPolicy: backoffPolicy,
      inputData: inputData,
    );
  }
}

@pragma('vm:entry-point')
void onBackgroundTask() {
  Workmanager().executeTask((taskName, inputData) async {
    final container = ProviderContainer();
    await initializeLocalNotificationsPlugin(container.read, background: true);
    initializeLogger();

    try {
      switch (taskName) {
        case AppUpdateCheckTask.name:
          return const AppUpdateCheckTask().call(container, inputData);
        case AppUpdateDownloadTask.name:
          return const AppUpdateDownloadTask().call(container, inputData);
        default:
          return Future.value(true);
      }
    } catch (e) {
      return Future.error(e);
    }
  });
}

enum BackgroundTaskTag {
  updateApp,
}
