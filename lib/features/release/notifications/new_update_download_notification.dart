import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';
import 'actions/actions.dart';

const _channel = NotificationChannel.appUpdateCheck;
const _downloadingTitle = 'Downloading update...';
const _cancelAction =
    AndroidNotificationAction(AppUpdateCancelAction.id, 'Cancel');

abstract class NewUpdateDownloadNotification extends Notification {
  const NewUpdateDownloadNotification();

  const factory NewUpdateDownloadNotification.initializing() =
      _DownloadInitializing;

  const factory NewUpdateDownloadNotification.progress(int value, int total) =
      _DownloadProgress;

  const factory NewUpdateDownloadNotification.finalizing(String message) =
      _DownloadFinalizing;

  const factory NewUpdateDownloadNotification.complete(String filePath) =
      _DownloadComplete;

  const factory NewUpdateDownloadNotification.error(
      ReleaseWithDownloadAssets release, String message) = _DownloadError;
}

class _DownloadInitializing extends NewUpdateDownloadNotification {
  const _DownloadInitializing();

  @override
  String get title => _downloadingTitle;

  @override
  String get body => 'Initializing...';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: false,
        ongoing: true,
        autoCancel: false,
        showProgress: true,
        indeterminate: true,
        category: AndroidNotificationCategory.progress,
        actions: [
          _cancelAction,
        ],
      ),
    );
  }
}

class _DownloadProgress extends NewUpdateDownloadNotification {
  const _DownloadProgress(this.value, this.total);

  final int value;
  final int total;

  @override
  String get title => _downloadingTitle;

  @override
  String get body => '${_formatBytes(value)}/${_formatBytes(total)}';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: false,
        autoCancel: false,
        ongoing: true,
        showProgress: true,
        maxProgress: total,
        progress: value,
        category: AndroidNotificationCategory.progress,
        actions: [
          _cancelAction,
        ],
      ),
    );
  }

  String _formatBytes(int count) {
    final value = count / (1024 * 1024);
    return '${value.toStringAsFixed(2)}MB';
  }
}

class _DownloadFinalizing extends NewUpdateDownloadNotification {
  const _DownloadFinalizing(this.message);

  final String message;

  @override
  String get title => _downloadingTitle;

  @override
  String get body => message;

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.low,
        priority: Priority.low,
        playSound: false,
        enableVibration: false,
        autoCancel: false,
        showProgress: true,
        progress: 1,
        maxProgress: 1,
        category: AndroidNotificationCategory.progress,
        actions: [
          _cancelAction,
        ],
      ),
    );
  }
}

class _DownloadComplete extends NewUpdateDownloadNotification {
  const _DownloadComplete(this.filePath);

  final String filePath;

  @override
  String get title => 'Download complete';

  @override
  String get body => 'Ready to install';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        autoCancel: false,
        actions: [
          const AndroidNotificationAction(AppUpdateInstallAction.id, 'Install'),
          const AndroidNotificationAction(VoidAction.id, 'Cancel'),
        ],
      ),
    );
  }

  @override
  String? get payload => jsonEncode({'filePath': filePath});
}

class _DownloadError extends NewUpdateDownloadNotification {
  const _DownloadError(this.release, this.message);

  final ReleaseWithDownloadAssets release;
  final String message;

  @override
  String get title => 'Download failed';

  @override
  String get body => message;

  @override
  NotificationDetails? get notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        autoCancel: false,
        category: AndroidNotificationCategory.error,
        actions: [
          const AndroidNotificationAction(AppUpdateDownloadAction.id, 'Retry'),
          const AndroidNotificationAction(VoidAction.id, 'Cancel'),
        ],
      ),
    );
  }

  @override
  String? get payload => jsonEncode(release.toJson());
}
