import 'dart:io' show Platform;

import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_info2/system_info2.dart';

const name = 'app';
const postfix = '-release';

final getDownloadLinkProvider = Provider.autoDispose(
  (ref) => GetDownloadLink(),
);

class DownloadAsset {
  const DownloadAsset({
    required this.apkAsset,
    required this.hashAsset,
  });

  final ReleaseAsset apkAsset;
  final ReleaseAsset hashAsset;
}

class GetDownloadLink {
  DownloadAsset? call(Release release) {
    String? filename;
    if (Platform.isAndroid) {
      filename = androidFilename();
    }

    if (filename == null) {
      return null;
    }

    return intoAssets(release, filename);
  }

  DownloadAsset? intoAssets(Release release, String apkFilename) {
    final hashFilename = '$apkFilename.sha1';

    final apkAsset =
        release.assets?.firstWhere((asset) => asset.name == apkFilename);
    final hashAsset =
        release.assets?.firstWhere((asset) => asset.name == hashFilename);

    if (apkAsset != null && hashAsset != null) {
      return DownloadAsset(apkAsset: apkAsset, hashAsset: hashAsset);
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
