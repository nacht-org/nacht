import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:github/github.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nacht/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart' as crypto;

import '../models/models.dart';
import '../notifications/notifications.dart';

final downloadReleaseProvider = Provider((ref) => const DownloadRelease());

class DownloadRelease with LoggerMixin {
  const DownloadRelease();

  Future<Either<Failure, File>> call(
    ReleaseWithDownloadAssets data,
    NotificationHandle handle,
  ) async {
    try {
      final result = await _download(data, handle);
      return Right(result);
    } catch (e) {
      return Left(ExceptionFailure(e));
    }
  }

  Future<File> _download(
    ReleaseWithDownloadAssets data,
    NotificationHandle handle,
  ) async {
    final dio = Dio();
    final cancelToken = CancelToken();

    handle.show(const NewUpdateDownloadNotification.initializing());

    final appFile = await _downloadAsset(
      dio: dio,
      asset: data.downloadAssets.appAsset,
      cancelToken: cancelToken,
      onReceiveProgress: (value, total) {
        handle.show(NewUpdateDownloadNotification.progress(value, total));
      },
    );

    handle.show(const NewUpdateDownloadNotification.finalizing(
        'Checking file integrity'));

    final hashFile = await _downloadAsset(
      dio: dio,
      asset: data.downloadAssets.hashAsset,
      cancelToken: cancelToken,
    );

    if (!await _checkDownloadIntegrity(appFile, hashFile)) {
      throw Exception("File integrity check failed");
    }

    return appFile;
  }

  Future<File> _downloadAsset({
    required Dio dio,
    required ReleaseAsset asset,
    required CancelToken cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await dio.get(
      asset.browserDownloadUrl!,
      options: Options(
        responseType: ResponseType.bytes,
      ),
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );

    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, asset.name);
    final file = File(filePath);
    await file.writeAsBytes(response.data);

    return file;
  }

  Future<bool> _checkDownloadIntegrity(File appFile, File hashFile) async {
    final appBytes = await appFile.readAsBytes();

    final actual = crypto.sha1.convert(appBytes).toString();
    final expected = (await hashFile.readAsString()).trim();

    log.fine(
        'app update download integrity check: actual=$actual expected=$expected');

    return actual == expected;
  }
}
