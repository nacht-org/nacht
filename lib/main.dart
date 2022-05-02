import 'package:chapturn/config/routes/app_router.dart';
import 'package:chapturn/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  initializeLogger();

  ErrorHandler(
    child: const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Chapturn',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
      routeInformationProvider: router.routeInfoProvider(),
    );
  }
}
