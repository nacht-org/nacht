import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return substring(0, 1).toUpperCase() + substring(1);
  }

  String pluralize({
    String suffix = 's',
    bool Function(String string)? test,
  }) {
    test = test ?? (_) => true;
    if (test(this)) {
      return this + suffix;
    }

    return this;
  }

  String stripFirst(String pattern) {
    if (isEmpty) {
      return this;
    }

    return startsWith(pattern) ? substring(pattern.length) : this;
  }
}

extension BrightnessExtension on Brightness {
  /// Returns the [SystemUiOverlayStyle] that would look best on [Brightness]
  SystemUiOverlayStyle getSystemUiOverlayStyle() {
    final brightness = switch (this) {
      Brightness.light => SystemUiOverlayStyle.dark,
      Brightness.dark => SystemUiOverlayStyle.light,
    };

    return brightness.copyWith(
      systemNavigationBarColor: Colors.transparent,
    );
  }
}
