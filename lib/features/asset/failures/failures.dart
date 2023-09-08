import 'dart:io';

import 'package:nacht/core/core.dart';

class AssetNotFound extends Failure {
  AssetNotFound(File? file)
      : super("Asset not found ${file == null ? '' : "at ${file.path}"}");
}

class AssetHashMismatch extends Failure {
  const AssetHashMismatch(this.calculatedHash, this.storedHash)
      : super("Asset hash mismatch");

  final String calculatedHash;
  final String storedHash;

  @override
  List<Object?> get props => [...super.props, calculatedHash, storedHash];
}
