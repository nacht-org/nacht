import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/splash/presentation/provider/application_provider.dart';
import 'package:nacht/nht/nht.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Disable http font downloads in release mode.
  GoogleFonts.config.allowRuntimeFetching = kDebugMode;

  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  ErrorHandler(
    sharedPreferences: sharedPreferences,
    child: ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      observers: [ProviderLogger()],
      child: const NachtApp(),
    ),
  );
}

class NachtApp extends HookConsumerWidget {
  const NachtApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final brightness = ref.watch(brightnessProvider);

    useEffect(() {
      ref.read(applicationProvider).init();
      return null;
    }, []);

    return MaterialApp.router(
      title: 'nacht',
      theme: themeFromBrightness(brightness),
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
      routeInformationProvider: router.routeInfoProvider(),
    );
  }

  ThemeData themeFromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          listTileTheme: ListTileThemeData(
            selectedTileColor: ThemeData.dark().cardColor,
          ),
          useMaterial3: true,
        );
      case Brightness.light:
        return ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          listTileTheme: ListTileThemeData(
            selectedTileColor: ThemeData.light().cardColor,
          ),
          useMaterial3: true,
        );
    }
  }
}
