import 'package:github/github.dart';
import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

class AppUpdateDownloadTask extends BackgroundTask<Release> {
  static const String name = 'AppUpdateDownload';

  @override
  Future<bool> execute(ProviderContainer container, Release data) async {
    print("downloading: ${data.name}");
    return true;
  }

  @override
  Release parseInput(Map<String, dynamic>? inputData) {
    return inputData!['release'];
  }
}
