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

    final textTheme = applyFont(theme.textTheme, data.fontFamily);

    return Theme(
      data: theme.copyWith(
        scrollbarTheme: data.colorMode.value != null
            ? theme.scrollbarTheme.copyWith(
                thumbColor:
                    MaterialStateProperty.all(data.colorMode.value!.textColor),
              )
            : theme.scrollbarTheme,
        textTheme: data.colorMode.value != null
            ? textTheme.apply(
                displayColor: data.colorMode.value!.textColor,
                bodyColor: data.colorMode.value!.textColor,
              )
            : textTheme,
      ),
      child: child,
    );
  }

  TextTheme applyFont(TextTheme textTheme, ReaderFontFamily fontFamily) {
    switch (fontFamily) {
      case ReaderFontFamily.basic:
        break;
      case ReaderFontFamily.lato:
        return GoogleFonts.latoTextTheme(textTheme);
    }

    return textTheme;
  }
}
