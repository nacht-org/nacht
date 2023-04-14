import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/shared/shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:workmanager/workmanager.dart';

import '../../background_tasks/background_tasks.dart';

class AppUpdateDownloadAction with LoggerMixin implements NotificationAction {
  static const String id = 'AppUpdate.Download';

  @override
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  ) async {
    final isConnectionAvailable =
        await container.read(getIsConnectionAvailableProvider).execute();
    if (!isConnectionAvailable) {
      log.info('update download cancelled: no internet connection');
      return;
    }

    Workmanager().registerOneOffTask(
      'update-download',
      AppUpdateDownloadTask.name,
      tag: BackgroundTaskTag.appUpdate,
      inputData: {'release': response.payload!},
    );
  }
}
