import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

mixin LoggerMixin {
  Logger get log => Logger('$runtimeType');
}

void initializeLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.FINE; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  if (kReleaseMode) {
    Logger.root.level = Level.INFO;
    // TODO: write to log file.
  }
}
