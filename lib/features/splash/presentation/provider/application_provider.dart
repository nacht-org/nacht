import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/common/common.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';
import 'package:webview_flutter/webview_flutter.dart';

final applicationProvider = Provider<Application>(
  (ref) => Application(read: ref.read),
  name: 'ApplicationProvider',
);

class Application with LoggerMixin {
  Application({
    required Reader read,
  }) : _read = read;

  final Reader _read;

  Future<void> init() async {
    initializeLogger();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      if (!systemOverlaysAreVisible) {
        await Future.delayed(const Duration(seconds: 3));
        SystemChrome.restoreSystemUIOverlays();
        log.fine('restored system ui overlays');
      }
    });

    _addLicenses();

    await Future.wait([
      _read(updatesProvider.notifier).initialize(),
      _read(categoriesProvider.notifier).initialize(),
    ]);

    await _read(routerProvider).replace(const HomeRoute());
  }

  void _addLicenses() {
    LicenseRegistry.addLicense(() async* {
      final ofl = await rootBundle.loadString('assets/google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], ofl);
    });
  }
}
