import 'package:chapturn/components/application/provider/application_provider.dart';
import 'package:chapturn/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'extrinsic/extrinsic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  initializeLogger();

  ErrorHandler(
    sharedPreferences: sharedPreferences,
    child: ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: [ProviderLogger()],
      child: const ChapturnApp(),
    ),
  );
}

class ChapturnApp extends HookConsumerWidget {
  const ChapturnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    useEffect(() {
      ref.read(applicationProvider).init();
      return null;
    }, []);

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
