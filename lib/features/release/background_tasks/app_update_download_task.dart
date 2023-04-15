import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github/github.dart';
import 'package:nacht/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart' as crypto;

import '../models/models.dart';
import '../notifications/notifications.dart';

class AppUpdateDownloadTask extends BackgroundTask<ReleaseWithDownloadAssets>
    with LoggerMixin {
  static const String name = 'AppUpdateDownload';

  @override
  Future<bool> execute(
    ProviderContainer container,
    ReleaseWithDownloadAssets data,
  ) async {
    log.info('started downloading in the background...');

    final handle = container.read(notificationServiceProvider).getHandle();

    try {
      final file = await _download(container, data, handle);
      handle.show(NewUpdateDownloadNotification.complete(file.path));
      log.info('download succeeded');
    } catch (e) {
      handle.show(NewUpdateDownloadNotification.error(data, e.toString()));
      log.info('app update download failed: $e');
    }

    return true;
  }

  Future<File> _download(
    ProviderContainer container,
    ReleaseWithDownloadAssets data,
    NotificationHandle handle,
  ) async {
    final dio = Dio();
    final cancelToken = CancelToken();

    handle.show(const NewUpdateDownloadNotification.initializing());

    // final appFile = await _downloadAsset(
    //   dio: dio,
    //   asset: data.downloadAssets.appAsset,
    //   cancelToken: cancelToken,
    //   onReceiveProgress: (value, total) =>
    //       handle.show(NewUpdateDownloadNotification.progress(value, total)),
    // );

    handle.show(const NewUpdateDownloadNotification.finalizing(
        'Checking file integrity'));

    final hashFile = await _downloadAsset(
      dio: dio,
      asset: data.downloadAssets.hashAsset,
      cancelToken: cancelToken,
    );

    // if (!await _checkDownloadIntegrity(appFile, hashFile)) {
    //   throw Exception("File integrity check failed");
    // }

    return File('');
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

  @override
  ReleaseWithDownloadAssets parseInput(Map<String, dynamic>? inputData) {
    return ReleaseWithDownloadAssets.fromJson(
      jsonDecode(inputData!['release']),
    );
  }
}
