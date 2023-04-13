import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github/github.dart';

part 'download_assets.freezed.dart';
part 'download_assets.g.dart';

@freezed
class DownloadAssets with _$DownloadAssets {
  const factory DownloadAssets({
    required ReleaseAsset appAsset,
    required ReleaseAsset hashAsset,
  }) = _DownloadAssets;

  factory DownloadAssets.fromJson(Map<String, dynamic> json) =>
      _$DownloadAssetsFromJson(json);

  const DownloadAssets._();
}
