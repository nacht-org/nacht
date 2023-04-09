import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:github/github.dart';

import '../failures/failures.dart';
import '../providers/providers.dart';

final getLatestReleaseProvider = Provider.autoDispose(
  (ref) => GetLatestRelease(
    gitHub: ref.watch(githubProvider),
  ),
);

final RepositorySlug _repository = RepositorySlug("nacht-org", 'nacht');

class GetLatestRelease {
  const GetLatestRelease({
    required GitHub gitHub,
  }) : _gitHub = gitHub;

  final GitHub _gitHub;

  Future<Either<Failure, Release>> call() async {
    try {
      final release = await _gitHub.repositories.getLatestRelease(_repository);
      return Right(release);
    } catch (e) {
      return Left(FailedToGetLatestRelease(e.toString()));
    }
  }
}
