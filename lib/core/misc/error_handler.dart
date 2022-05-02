import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// Calls [runApp] to run the app and catches any errors thrown by the Flutter
/// framework or dart.
///
/// * In debug mode, any caught errors will be printed to the console.
/// TODO: Write to file in release mode.
class ErrorHandler {
  ErrorHandler({
    required Widget child,
  }) {
    if (kReleaseMode) {
      // override the error widget in release mode (the red error screen)
      ErrorWidget.builder = (details) => const SizedBox();
    }

    if (kDebugMode) {
      Logger.root.level = Level.ALL; // defaults to Level.INFO
      Logger.root.onRecord.listen((record) {
        // ignore: avoid_print
        print('${record.level.name}: ${record.time}: ${record.message}');
      });
    }

    runApp(child);
  }
}
