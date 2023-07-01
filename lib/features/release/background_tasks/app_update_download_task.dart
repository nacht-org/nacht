import 'dart:convert';

import 'package:nacht/core/core.dart';
import 'package:nacht/features/release/services/services.dart';
import 'package:riverpod/riverpod.dart';

import '../models/models.dart';
import '../notifications/notifications.dart';

class AppUpdateDownloadTask extends BackgroundTask<ReleaseWithDownloadAssets>
    with LoggerMixin {
  const AppUpdateDownloadTask();

  static const name = 'AppUpdateDownload';
  static const id = BackgroundTaskId(
      'update.app.download', name, BackgroundTaskTag.updateApp);

  @override
  Future<bool> execute(
    ProviderContainer container,
    ReleaseWithDownloadAssets data,
  ) async {
    log.info('started downloading in the background...');

    final handle = container.read(notificationServiceProvider).getHandle();
    final result =
        await container.read(downloadReleaseProvider).call(data, handle);

    result.fold(
      (failure) {
        handle.show(NewUpdateDownloadNotification.error(data, failure.message));
        log.info('app update download failed: $failure');
      },
      (file) {
        handle.show(NewUpdateDownloadNotification.complete(file.path));
        log.info('download succeeded');
      },
    );

    return true;
  }

  @override
  ReleaseWithDownloadAssets parseInput(Map<String, dynamic>? inputData) {
    return ReleaseWithDownloadAssets.fromJson(
      jsonDecode(inputData!['release']),
    );
  }
}
