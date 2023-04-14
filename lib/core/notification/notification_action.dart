import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class NotificationAction {
  Future<void> execute(
    ProviderContainer container,
    NotificationResponse response,
  );
}

class VoidAction {
  static const String id = 'void';
}
