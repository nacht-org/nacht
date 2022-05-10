import 'package:chapturn/core/failure.dart';

class NovelNotFound extends Failure {
  const NovelNotFound();
  @override
  List<Object?> get props => [];
}

class CoverNotAvailable extends Failure {
  const CoverNotAvailable();
  @override
  List<Object?> get props => [];
}

class NetworkNotAvailable extends Failure {
  const NetworkNotAvailable();
  @override
  List<Object?> get props => [];
}

class DownloadFailed extends Failure {
  const DownloadFailed(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class UnknownAssetType extends Failure {
  const UnknownAssetType();
  @override
  List<Object?> get props => [];
}

class FileSaveError extends Failure {
  const FileSaveError();
  @override
  List<Object?> get props => [];
}

class SameAssetError extends Failure {
  const SameAssetError();
  @override
  List<Object?> get props => [];
}

class AssetNotFound extends Failure {
  const AssetNotFound();
  @override
  List<Object?> get props => [];
}

class AssetDeleteFailure extends Failure {
  const AssetDeleteFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class InsertFailure extends Failure {
  const InsertFailure();

  @override
  List<Object?> get props => [];
}
