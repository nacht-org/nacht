import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:github/github.dart' hide Notification;
import 'package:nacht/core/core.dart';

import '../models/models.dart';
import 'actions/actions.dart';

class NewUpdateNotification extends Notification {
  const NewUpdateNotification(this.release, this.downloadAssets);

  final Release release;
  final DownloadAssets downloadAssets;

  @override
  String get title => 'New version available';

  @override
  String get body => 'Version ${release.tagName} is available for download';

  @override
  NotificationDetails? get notificationDetails {
    return NotificationChannels.updatesApp.simple(
      actions: [
        NotificationAction.simple(AppUpdateDownloadAction.id, 'Download'),
        if (release.tagName != null)
          NotificationAction.simple(
            AppUpdateWhatsNewAction.id,
            "What's new",
            cancelNotification: false,
            showsUserInterface: true,
          ),
      ],
    );
  }

  @override
  String? get payload {
    return jsonEncode(
      ReleaseWithDownloadAssets(
        release: release,
        downloadAssets: downloadAssets,
      ).toJson(),
    );
  }
}
