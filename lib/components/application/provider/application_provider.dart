import 'dart:io';

import 'package:nacht/components/library/provider/library_provider.dart';
import 'package:nacht/components/updates/provider/updates_provider.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/core.dart';

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

    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      await Future.delayed(const Duration(seconds: 3));
      SystemChrome.restoreSystemUIOverlays();
      log.fine('restored system ui overlays');
    });

    await Future.wait([
      _read(libraryProvider.notifier).reload(),
      _read(updatesProvider.notifier).fetch(),
    ]);

    _read(routerProvider).replace(const HomeRoute());
  }
}
