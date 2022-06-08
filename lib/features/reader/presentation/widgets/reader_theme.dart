import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

class ReaderTheme extends ConsumerWidget {
  const ReaderTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final preferences = ref.watch(readerPreferencesProvider);

    return Theme(
      data: theme.copyWith(
        textTheme: textTheme(theme, preferences.fontFamily),
      ),
      child: child,
    );
  }

  TextTheme? textTheme(ThemeData theme, ReaderFontFamily fontFamily) {
    switch (fontFamily) {
      case ReaderFontFamily.basic:
        break;
      case ReaderFontFamily.lato:
        return GoogleFonts.latoTextTheme(theme.textTheme);
    }

    return null;
  }
}
