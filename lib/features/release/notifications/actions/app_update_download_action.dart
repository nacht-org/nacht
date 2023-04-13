import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/release/models/models.dart';
import 'package:nacht/shared/shared.dart';
import 'package:riverpod/riverpod.dart';
import 'package:workmanager/workmanager.dart';

import '../../background_tasks/background_tasks.dart';

class AppUpdateDownloadAction with LoggerMixin implements NotificationAction {
  static const String id = 'AppUpdateCheck.download';

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

    final data =
        ReleaseWithDownloadAssets.fromJson(jsonDecode(response.payload!));

    Workmanager().registerOneOffTask(
      'update-download',
      AppUpdateDownloadTask.name,
      inputData: {'release': data},
    );
  }

  String _formatBytes(int count) {
    final value = count / (1024 ^ 2);
    return value.toStringAsFixed(2);
  }
}
