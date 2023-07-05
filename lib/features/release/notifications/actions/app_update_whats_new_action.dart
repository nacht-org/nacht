import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:nacht/features/release/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateWhatsNewAction
    with LoggerMixin
    implements NotificationActionTask {
  static const String id = 'AppUpdate.WhatsNew';

  @override
  Future<void> execute(RefRead read, NotificationResponse response) async {
    final data =
        ReleaseWithDownloadAssets.fromJson(jsonDecode(response.payload!));
    await launchUrl(
      // This action is only available if release have a tagName
      // so this is safe
      data.release.getUri()!,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }
}
