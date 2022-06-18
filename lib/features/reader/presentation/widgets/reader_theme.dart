import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/core/preferences/reader/models/reader_color_mode.dart';

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
    final theme = Theme.of(context);
    final data = ref.watch(readerPreferencesProvider.select(
      (value) => ReaderThemeData(
        colorMode: value.colorMode,
        fontFamily: value.fontFamily,
      ),
    ));

    final brightness = data.colorMode.value?.brightness ?? theme.brightness;
    final textTheme = textThemeFromBrightness(theme.typography, brightness);

    return Theme(
      data: theme.copyWith(
        brightness: brightness,
        textTheme: applyFont(textTheme, data.fontFamily),
      ),
      child: child,
    );
  }

  TextTheme? applyFont(TextTheme textTheme, ReaderFontFamily fontFamily) {
    switch (fontFamily) {
      case ReaderFontFamily.basic:
        break;
      case ReaderFontFamily.lato:
        return GoogleFonts.latoTextTheme(textTheme);
    }

    return null;
  }

  TextTheme textThemeFromBrightness(
      Typography typography, Brightness brightness,) {
    switch (brightness) {
      case Brightness.dark:
        return typography.white;
      case Brightness.light:
        return typography.black;
    }
  }
}
