import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/services.dart';

class AppUpdateInstallAction
    with LoggerMixin
    implements NotificationActionTask {
  static const String id = 'AppUpdate.Install';

  @override
  Future<void> execute(
    RefRead read,
    NotificationResponse response,
  ) async {
    final inputData = jsonDecode(response.payload!);
    final filePath = inputData['filePath'];

    final permissionGranted =
        await Permission.requestInstallPackages.request().isGranted;
    if (!permissionGranted) {
      return;
    }

    final result = await read(installApkProvider).call(filePath);
    result.fold(
      (failure) => print(failure),
      (_) {},
    );
  }
}
