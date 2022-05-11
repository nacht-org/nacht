import 'package:chapturn/core/core.dart';
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
    return showSnackbar(SnackBar(content: Text(text)));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackbar(
    SnackBar snackBar,
  ) {
    final context = _read(routerProvider).navigatorKey.currentContext;
    assert(context != null);

    if (context != null) {
      final messenger = ScaffoldMessenger.maybeOf(context);
      assert(messenger != null);

      return messenger?.showSnackBar(snackBar);
    } else {
      return null;
    }
  }
}