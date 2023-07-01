import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:nacht/features/release/failures/failures.dart';

final installApkProvider = Provider((ref) => const InstallApk());

class InstallApk {
  const InstallApk();

  static const MethodChannel _channel = MethodChannel('org.nacht/install_apk');

  Future<Either<Failure, void>> call(String filePath) async {
    try {
      await _channel
          .invokeMethod('installApk', {'filePath': filePath});
      return const Right(null);
    } on PlatformException catch (e) {
      return Left(FailedToInstallApk(filePath, e.toString()));
    }
  }
}
