import 'dart:io' show Platform;

import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_info2/system_info2.dart';

import '../models/models.dart';

const name = 'app';
const postfix = '-release';

final getPlatformDownloadAssetsProvider = Provider.autoDispose(
  (ref) => GetPlatformDownloadAssets(),
);

class GetPlatformDownloadAssets {
  DownloadAssets? call(Release release) {
    String? filename;
    if (Platform.isAndroid) {
      filename = androidFilename();
    }

    if (filename == null) {
      return null;
    }

    return intoAssets(release, filename);
  }

  DownloadAssets? intoAssets(Release release, String appFilename) {
    final hashFilename = '$appFilename.sha1';

    final appAsset =
        release.assets?.firstWhere((asset) => asset.name == appFilename);
    final hashAsset =
        release.assets?.firstWhere((asset) => asset.name == hashFilename);

    if (appAsset != null && hashAsset != null) {
      return DownloadAssets(appAsset: appAsset, hashAsset: hashAsset);
    } else {
      return null;
    }
  }

  String androidFilename() {
    var arch = SysInfo.kernelArchitecture.name;
    if (arch == ProcessorArchitecture.arm64.name) {
      arch = 'arm64-v8a';
    } else if (arch == ProcessorArchitecture.arm.name) {
      arch = 'armeabi-v7a';
    }

    final filename = '$name-$arch$postfix.apk';
    return filename;
  }
}
