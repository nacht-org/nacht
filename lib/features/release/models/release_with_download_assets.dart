import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github/github.dart';

import 'download_assets.dart';

part 'release_with_download_assets.freezed.dart';
part 'release_with_download_assets.g.dart';

@freezed
class ReleaseWithDownloadAssets with _$ReleaseWithDownloadAssets {
  const factory ReleaseWithDownloadAssets({
    required Release release,
    required DownloadAssets downloadAssets,
  }) = _ReleaseWithDownloadAssets;

  factory ReleaseWithDownloadAssets.fromJson(Map<String, dynamic> json) =>
      _$ReleaseWithDownloadAssetsFromJson(json);

  const ReleaseWithDownloadAssets._();
}
