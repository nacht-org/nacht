import 'package:nacht/core/logger/logger.dart';
import 'package:nacht/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dialogServiceProvider = Provider<DialogService>(
  (ref) => DialogService(read: ref.read),
  name: 'DIalogServiceProvider',
);

class DialogService with LoggerMixin {
  DialogService({required Reader read}) : _read = read;

  final Reader _read;

  Future<T?> show<T>({required Widget child}) {
    final context = _read(routerProvider).navigatorKey.currentContext;
    assert(context != null);

    return showDialog<T>(
      context: context!,
      builder: (_) => child,
    );
  }
}
