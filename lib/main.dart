import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/splash/provider/application_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:workmanager/workmanager.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  // Disable http font downloads in release mode.
  GoogleFonts.config.allowRuntimeFetching = kDebugMode;

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(onBackgroundTask, isInDebugMode: kDebugMode);

  final sharedPreferences = await SharedPreferences.getInstance();

  ErrorHandler(
    sharedPreferences: sharedPreferences,
    child: ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      // observers: [ProviderLogger()],
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

      initializeLocalNotificationsPlugin();
      Permission.notification.request();

      NotificationGroups.createAll();
      NotificationChannels.createAll();
      return null;
    }, []);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? colorScheme;
        switch (brightness) {
          case Brightness.dark:
            colorScheme = darkDynamic;
            break;
          case Brightness.light:
            colorScheme = lightDynamic;
            break;
        }

        colorScheme ??= ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: const Color(0xFF25316D),
        );

        return MaterialApp.router(
          title: 'nacht',
          theme: themeFromBrightness(brightness, colorScheme),
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.defaultRouteParser(),
          routerDelegate: router.delegate(),
          routeInformationProvider: router.routeInfoProvider(),
        );
      },
    );
  }

  ThemeData themeFromBrightness(
      Brightness brightness, ColorScheme colorScheme) {
    final theme = ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      useMaterial3: true,
    );

    return theme.copyWith(
      listTileTheme: theme.listTileTheme.copyWith(
        selectedTileColor: theme.colorScheme.surfaceVariant,
      ),
    );
  }
}
