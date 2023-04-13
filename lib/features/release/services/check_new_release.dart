import 'package:dartz/dartz.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

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

    return release.fold(
      (failure) => Left(failure),
      (data) {
        log.info("found new release");
        return Right(data);
      },
    );
  }
}
