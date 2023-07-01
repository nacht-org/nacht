import 'package:dartz/dartz.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

import 'services.dart';

final checkNewReleaseProvider = Provider.autoDispose(
  (ref) => CheckNewRelease(
    getLatestRelease: ref.watch(getLatestReleaseProvider),
  ),
);

class CheckNewRelease with LoggerMixin {
  const CheckNewRelease({
    required GetLatestRelease getLatestRelease,
  }) : _getLatestRelease = getLatestRelease;

  final GetLatestRelease _getLatestRelease;

  Future<Either<Failure, Release?>> call() async {
    log.info("checking for new release");

    final release = await _getLatestRelease.call();
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = Version.parse(packageInfo.version.stripFirst("v"));

    return release.fold(
      (failure) => Left(failure),
      (data) {
        if (data.tagName == null) {
          return const Right(null);
        }

        final latestVersion = Version.parse(data.tagName!.stripFirst("v"));
        if (latestVersion > currentVersion) {
          return Right(data);
        }

        log.info(
            "the latest version ($latestVersion) >= current ($currentVersion)");
        return const Right(null);
      },
    );
  }
}
