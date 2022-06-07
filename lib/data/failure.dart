import 'package:nacht/core/failure.dart';

class CoverNotAvailable extends Failure {
  const CoverNotAvailable([super.message]);
}

class NetworkNotAvailable extends Failure {
  const NetworkNotAvailable([super.message]);
}

class DownloadFailed extends Failure {
  const DownloadFailed(super.message);
}

class UnknownAssetType extends Failure {
  const UnknownAssetType([super.message]);
}

class FileSaveError extends Failure {
  const FileSaveError([super.message]);
}

class SameAssetError extends Failure {
  const SameAssetError([super.message]);
}

class AssetNotFound extends Failure {
  const AssetNotFound([super.message]);
}

class AssetDeleteFailure extends Failure {
  const AssetDeleteFailure(super.message);
}

class InsertFailure extends Failure {
  const InsertFailure([super.message]);
}

class UpdateFailure extends Failure {
  const UpdateFailure([super.message]);
}

class SelectFailure extends Failure {}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
