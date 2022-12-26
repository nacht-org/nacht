import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/shared/shared.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/features.dart';

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
      _ref.read(updatesProvider.notifier).initialize(),
      _ref.read(categoriesProvider.notifier).initialize(),
      _ref.read(historyProvider.notifier).init(),
    ]);

    await _ref.read(routerProvider).replace(const HomeRoute());
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
