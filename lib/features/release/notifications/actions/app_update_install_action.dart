import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

class InstallApk {
  static const MethodChannel _channel = MethodChannel('org.nacht/install_apk');

  static Future<void> install(String filePath) async {
    try {
      await _channel.invokeMethod('installApk', {'filePath': filePath});
    } on PlatformException catch (e) {
      throw 'Failed to install APK file: ${e.message}';
    }
  }
}

class AppUpdateInstallAction with LoggerMixin implements NotificationAction {
  static const String id = 'AppUpdate.Install';

  @override
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  ) async {
    final inputData = jsonDecode(response.payload!);
    final filePath = inputData['filePath'];
    InstallApk.install(filePath);
  }
}
