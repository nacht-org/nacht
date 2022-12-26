import 'package:nacht/core/logger/logger.dart';
import 'package:nacht/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dialogServiceProvider = Provider<DialogService>(
  (ref) => DialogService(ref: ref),
  name: 'DIalogServiceProvider',
);

class DialogService with LoggerMixin {
  DialogService({required Ref ref}) : _ref = ref;

  final Ref _ref;

  Future<T?> show<T>({required Widget child}) {
    final context = _ref.read(routerProvider).navigatorKey.currentContext;
    assert(context != null);

    return showDialog<T>(
      context: context!,
      builder: (_) => child,
    );
  }
}
