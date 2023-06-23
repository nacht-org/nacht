import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';

import '../models/models.dart';
import 'actions/actions.dart';

const _downloadingTitle = 'New version available';
final _cancelAction =
    NotificationAction.simple(AppUpdateCancelAction.id, 'Cancel');

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
    return NotificationChannels.downloaderProgress.progress(
      indeterminate: true,
      actions: [_cancelAction],
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
    return NotificationChannels.downloaderProgress.progress(
      maxProgress: total,
      progress: value,
      actions: [_cancelAction],
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
    return NotificationChannels.downloaderProgress.progress(
      maxProgress: 1,
      progress: 1,
      actions: [_cancelAction],
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
    return NotificationChannels.updatesApp.simple(
      actions: [
        NotificationAction.simple(AppUpdateInstallAction.id, 'Install'),
        NotificationAction.simple(VoidAction.id, 'Cancel'),
      ],
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
    return NotificationChannels.updatesApp.simple(
      actions: [
        NotificationAction.simple(AppUpdateDownloadAction.id, 'Retry'),
        NotificationAction.simple(VoidAction.id, 'Cancel'),
      ],
    );
  }

  @override
  String? get payload => jsonEncode(release.toJson());
}
