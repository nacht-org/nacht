import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';

part 'new_update_download_notification.freezed.dart';

const _channel = NotificationChannel.appUpdateCheck;

@freezed
class NewUpdateDownloadState with _$NewUpdateDownloadState {
  const factory NewUpdateDownloadState.initializing() =
      _NewUpdateDownloadInitializing;

  const factory NewUpdateDownloadState.progress(int current, int total) =
      _NewUpdateDownloadProgress;

  const factory NewUpdateDownloadState.finalizing() =
      _NewUpdateDownloadFinalizing;

  const factory NewUpdateDownloadState.success(
    String filePath,
  ) = _NewUpdateDownloadSuccess;

  const factory NewUpdateDownloadState.error(
    ReleaseWithDownloadAssets release,
    String message,
  ) = _NewUpdateDownloadError;
}

class NewUpdateDownloadNotification extends Notification {
  const NewUpdateDownloadNotification({required this.state});

  final NewUpdateDownloadState state;

  @override
  String get title {
    return state.maybeWhen(
      success: (_) => 'Download complete',
      error: (_, __) => 'Download failed',
      orElse: () => 'Downloading update...',
    );
  }

  @override
  String get body {
    return state.when(
      initializing: () => 'Initializing...',
      progress: (value, total) =>
          '${_formatBytes(value)}/${_formatBytes(total)}',
      finalizing: () => 'Almost done...',
      success: (_) => 'Ready to install',
      error: (_, message) => message,
    );
  }

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.low,
        priority: Priority.low,
        ongoing: true,
        playSound: false,
        enableVibration: false,
        autoCancel: false,
        maxProgress: 100,
        progress: state.maybeWhen(
          progress: (current, total) => ((current / total) * 100).round(),
          finalizing: () => 100,
          orElse: () => 0,
        ),
        indeterminate: state.maybeWhen(
          initializing: () => true,
          orElse: () => false,
        ),
        showProgress: state.maybeWhen(
          initializing: () => true,
          progress: (_, __) => true,
          finalizing: () => true,
          orElse: () => false,
        ),
        actions: [
          AndroidNotificationAction('AppUpdateDownload.cancel', 'Cancel'),
        ],
      ),
    );
  }

  String _formatBytes(int count) {
    final value = count / (1024 * 1024);
    return '${value.toStringAsFixed(2)}MB';
  }
}
