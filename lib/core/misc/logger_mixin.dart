import 'package:logging/logging.dart';

mixin LoggerMixin {
  Logger get log {
    return Logger('$runtimeType');
  }
}
