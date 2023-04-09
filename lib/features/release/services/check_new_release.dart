import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';

import 'services.dart';

final checkNewReleaseProvider = Provider.autoDispose(
  (ref) => CheckNewRelease(
    ref: ref,
    getLatestRelease: ref.watch(getLatestReleaseProvider),
  ),
);

class CheckNewRelease with LoggerMixin {
  const CheckNewRelease({
    required Ref ref,
    required GetLatestRelease getLatestRelease,
  })  : _ref = ref,
        _getLatestRelease = getLatestRelease;

  final Ref _ref;
  final GetLatestRelease _getLatestRelease;

  Future<Either<Failure, void>> call() async {
    log.info("checking for new release");
    final release = await _getLatestRelease.call();

    return release.fold(
      (failure) => Left(failure),
      (data) {
        log.info("found new release");
        _ref.read(routerProvider).push(NewReleaseRoute(release: data));
        return const Right(null);
      },
    );
  }
}
