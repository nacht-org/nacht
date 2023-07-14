import 'package:dynamic_color/dynamic_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

class ReaderThemeData extends Equatable {
  const ReaderThemeData({
    required this.colorMode,
    required this.fontFamily,
  });

  final ReaderColorMode colorMode;
  final ReaderFontFamily fontFamily;

  @override
  List<Object?> get props => [colorMode, fontFamily];
}

class ReaderTheme extends ConsumerWidget {
  const ReaderTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(brightnessProvider);
    final data = ref.watch(readerPreferencesProvider.select(
      (value) => ReaderThemeData(
        colorMode: value.colorMode,
        fontFamily: value.fontFamily,
      ),
    ));

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? colorScheme;
        switch (data.colorMode.value?.brightness ?? brightness) {
          case Brightness.dark:
            colorScheme = darkDynamic;
            break;
          case Brightness.light:
            colorScheme = lightDynamic;
            break;
        }

        final theme = ThemeData(
          brightness: data.colorMode.value?.brightness ?? brightness,
          colorScheme: colorScheme,
          useMaterial3: true,
        );

        final textTheme = data.fontFamily.getTextTheme(theme.textTheme);

        return Theme(
          data: theme.copyWith(
            scrollbarTheme: data.colorMode.value != null
                ? theme.scrollbarTheme.copyWith(
                    thumbColor: MaterialStateProperty.all(
                        data.colorMode.value!.textColor),
                  )
                : theme.scrollbarTheme,
            textTheme: data.colorMode.value != null
                ? textTheme?.apply(
                    displayColor: data.colorMode.value!.textColor,
                    bodyColor: data.colorMode.value!.textColor,
                  )
                : textTheme,
          ),
          child: child,
        );
      },
    );
  }
}
