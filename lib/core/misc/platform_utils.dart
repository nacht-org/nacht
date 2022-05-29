import 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:nacht_sources/nacht_sources.dart' show SupportPlatform;

SupportPlatform? _platform;

SupportPlatform currentPlatform() {
  if (_platform != null) {
    return _platform!;
  }

  _platform = _currentPlatform();
  return _platform!;
}

SupportPlatform _currentPlatform() {
  if (kIsWeb) {
    return SupportPlatform.web;
  }

  if (io.Platform.isAndroid) {
    return SupportPlatform.mobile;
  } else if (io.Platform.isIOS) {
    return SupportPlatform.mobile;
  } else if (io.Platform.isFuchsia) {
    return SupportPlatform.mobile;
  } else if (io.Platform.isLinux) {
    return SupportPlatform.desktop;
  } else if (io.Platform.isMacOS) {
    return SupportPlatform.desktop;
  } else if (io.Platform.isWindows) {
    return SupportPlatform.desktop;
  } else if (io.Platform.isWindows) {
    return SupportPlatform.desktop;
  }

  throw Exception(
      'Unable to identify platform, running on unsupported platform.');
}
