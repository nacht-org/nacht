import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/notification/notification.dart';

import '../notifications/notifications.dart';

final incognitoProvider = StateNotifierProvider<IncognitoNotifier, bool>(
  (ref) => IncognitoNotifier(
      notificationService: ref.watch(notificationServiceProvider)),
);

class IncognitoNotifier extends StateNotifier<bool> {
  IncognitoNotifier({
    required this.notificationService,
  }) : super(false);

  final NotificationService notificationService;

  void setIncognito(bool value) {
    value ? enable() : disable();
  }

  void disableDiscrete() {
    state = false;
  }

  void enable() {
    state = true;
    final handle = notificationService.getHandle(id: IncognitoNotification.id);
    handle.show(const IncognitoNotification());
  }

  void disable() {
    state = false;
    notificationService.cancel(IncognitoNotification.id);
  }
}
