import 'package:nacht/core/core.dart';
import 'package:riverpod/riverpod.dart';

import '../models/models.dart';

class AppUpdateDownloadTask extends BackgroundTask<ReleaseWithDownloadAssets> {
  static const String name = 'AppUpdateDownload';

  @override
  Future<bool> execute(
    ProviderContainer container,
    ReleaseWithDownloadAssets data,
  ) async {
    print("downloading: ${data.release.name}");
    return true;
  }

  @override
  ReleaseWithDownloadAssets parseInput(Map<String, dynamic>? inputData) {
    return inputData!['release'];
  }
}
