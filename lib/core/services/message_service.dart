import 'package:nacht/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageServiceProvider = Provider<MessageService>(
  (ref) => MessageService(read: ref.read),
  name: 'MessageServiceProvider',
);

class MessageService {
  MessageService({
    required Reader read,
  }) : _read = read;

  final Reader _read;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showText(
    String text,
  ) {
    return showSnackBar(SnackBar(
      content: Text(text),
      margin: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> showUndo(
    String message, {
    required VoidCallback onUndo,
    required VoidCallback orElse,
    Duration duration = const Duration(seconds: 2),
  }) async {
    final handle = showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(label: 'Undo', onPressed: onUndo),
        margin: const EdgeInsets.all(8.0),
        behavior: SnackBarBehavior.floating,
      ),
    );

    switch (await handle.closed) {
      case SnackBarClosedReason.action:
        return;
      default:
        orElse();
        break;
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    final context = _read(routerProvider).navigatorKey.currentContext;
    assert(context != null);

    final messenger = ScaffoldMessenger.maybeOf(context!);
    assert(messenger != null);

    return messenger!.showSnackBar(snackBar);
  }
}
