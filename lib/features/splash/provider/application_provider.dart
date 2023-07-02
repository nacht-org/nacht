import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:permission_handler/permission_handler.dart';

final applicationProvider = Provider<Application>(
  (ref) => Application(ref: ref),
  name: 'ApplicationProvider',
);

class Application with LoggerMixin {
  Application({
    required Ref ref,
  }) : _ref = ref;

  final Ref _ref;

  Future<void> init() async {
    initializeLogger();

    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      if (!systemOverlaysAreVisible) {
        await Future.delayed(const Duration(seconds: 3));
        SystemChrome.restoreSystemUIOverlays();
        log.fine('restored system ui overlays');
      }
    });

    _addLicenses();

    await Future.wait([
      _ref.read(updatesProvider.notifier).initialize(),
      _ref.read(categoriesProvider.notifier).initialize(),
      _ref.read(historyProvider.notifier).init(),
      _ref.read(downloadListProvider.notifier).init(),
    ]);

    _ref.read(downloadRunnerProvider);

    await _ref.read(routerProvider).replace(const HomeRoute());

    // TODO: handle if app was opened from notification
  }

  Future<FlutterLocalNotificationsPlugin> initializeNotification() async {
    final granted = await Permission.notification.request().isGranted;

    final plugin = await initializeLocalNotificationsPlugin(_ref.read);
    if (granted) {
      NotificationGroups.createAll();
      NotificationChannels.createAll();

      // These handle non-routing things
      await handleAppLaunchNotification(plugin, _ref.read);
    }

    return plugin;
  }

  void _addLicenses() {
    LicenseRegistry.addLicense(() async* {
      final lato =
          await rootBundle.loadString('assets/google_fonts/Lato/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], lato);

      final openSans = await rootBundle
          .loadString('assets/google_fonts/Open_Sans/LICENSE.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], openSans);
    });
  }
}
