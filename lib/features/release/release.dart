import 'package:github/github.dart';
import 'package:nacht/core/constants.dart' as constants;

export 'views/new_release_page.dart';
export 'services/check_new_release_and_route.dart';
export 'notifications/new_update_notification.dart';

extension ReleaseExtension on Release {
  Uri? getUri() {
    return tagName != null
        ? Uri.parse("${constants.github}/releases/tag/$tagName")
        : null;
  }
}
