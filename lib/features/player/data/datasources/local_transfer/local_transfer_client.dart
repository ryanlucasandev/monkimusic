import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/transfer_session_model.dart';
import 'package:media_store_plus/media_store_plus.dart';

class LocalTransferClient {
  final HttpClient _client = HttpClient();

  Future<TransferSessionModel> fetchTransferSession(
    ShareConnectionModel connection,
  ) async {
    print('CONNECTING TO ${connection.ip}:${connection.port}');
    try {
      final uri = Uri.parse(
        'http://${connection.ip}:${connection.port}/session?token=${connection.token}',
      );

      final request = await _client.getUrl(uri);

      final response = await request.close().timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to get session');
      }

      final body = await response.transform(utf8.decoder).join();

      final json = jsonDecode(body) as Map<String, dynamic>;

      return TransferSessionModel.fromJson(json);
    } on SocketException {
      throw Exception('Cannot connect to sender');
    } on TimeoutException {
      throw Exception('Sender did not respond');
    } catch (e) {
      throw Exception('Transfer failed: $e');
    }
  }

  Future<void> transferComplete(ShareConnectionModel connection) async {
    final uri = Uri.parse(
      'http://${connection.ip}:${connection.port}/complete?token=${connection.token}',
    );

    final request = await _client.postUrl(uri);
    final response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(
        'Failed to complete transfer: ${response.statusCode}',
      );
    }
  }

  Future<void> transferCancel(ShareConnectionModel connection) async {
    final uri = Uri.parse(
      'http://${connection.ip}:${connection.port}/cancel?token=${connection.token}',
    );

    final request = await _client.postUrl(uri);
    final response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException('Failed to cancel transfer: ${response.statusCode}');
    }
  }

  Future<String?> downloadSong(
    ShareConnectionModel connection,
    SongsModel song,
    Directory directory, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final uri = Uri.parse(
        'http://${connection.ip}:${connection.port}'
        '/download?songId=${song.songId}&token=${connection.token}',
      );

      final request = await _client.getUrl(uri);

      final response = await request.close().timeout(
        const Duration(minutes: 5),
      );

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to download ${song.title}');
      }

      final filename = '${_sanitizeFilename(song.title ?? 'Unknown Song')}.mp3';

      final file = File('${directory.path}/$filename');

      print('DIRECTORY EXISTS: ${await directory.exists()}');
      print('FILE PATH: ${file.path}');

      print('OPENING FILE');

      final sink = file.openWrite();

      print('STATUS CODE: ${response.statusCode}');
      print('CONTENT LENGTH: ${response.contentLength}');

      var receivedBytes = 0;

      await for (final chunk in response) {
        receivedBytes += chunk.length;
        sink.add(chunk);

        print('RECEIVED: $receivedBytes bytes');

        if (response.contentLength > 0) {
          final progress = receivedBytes / response.contentLength;
          print('DOWNLOAD PROGRESS: $progress');
          onProgress?.call(progress);
        }
      }

      await sink.close();

      print('STREAM FINISHED');
      print('FILE EXISTS: ${await file.exists()}');
      print('FILE SIZE: ${await file.length()}');

      print('STARTING MEDI_STORE SAVE');

      final mediaStore = MediaStore();

      SaveInfo? result;

      try {
        result = await mediaStore.saveFile(
          tempFilePath: file.path,
          dirType: DirType.audio,
          dirName: DirName.music,
          relativePath: "MonkiMusic",
        );
        print('SAVED TO: $result');
        print('URI: ${result?.uri}');
      } catch (e, stack) {
        print('MEDIA STORE ERROR: $e');
        print(stack);
      }

      if (result != null) {
        if (await file.exists()) {
          print('DELETING TEMP FILE');
          await file.delete();
        }
      }

      return result?.uri.toString();
    } on SocketException {
      throw Exception('Disconnected from sender');
    } on TimeoutException {
      throw Exception('Download timeout ${song.title}');
    } catch (e) {
      throw Exception('Failed downloading ${song.title}: $e');
    }
  }

  File getUniqueFile(Directory directory, String filename) {
    var file = File('${directory.path}/$filename');

    var counter = 1;

    while (file.existsSync()) {
      final name = filename.replaceFirst('.mp3', '_$counter.mp3');

      file = File('${directory.path}/$name');
      counter++;
    }

    return file;
  }

  String _sanitizeFilename(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  Future<File> saveSongToMusicFolder(File file, String filename) async {
    final mediaStore = MediaStore();

    final result = await mediaStore.saveFile(
      tempFilePath: file.path,
      dirType: DirType.audio,
      dirName: DirName.music,
      relativePath: "MonkiMusic",
    );

    print("SAVED TO: $result");

    return file;
  }

  Future<String> getUniqueFilename(Directory directory, String filename) async {
    final dotIndex = filename.lastIndexOf('.');

    final baseName = dotIndex == -1
        ? filename
        : filename.substring(0, dotIndex);

    final extension = dotIndex == -1 ? '' : filename.substring(dotIndex);

    var uniqueName = filename;
    var counter = 1;

    while (await File('${directory.path}/$uniqueName').exists()) {
      uniqueName = '$baseName ($counter)$extension';
      counter++;
    }

    return uniqueName;
  }

  void dispose() {
    _client.close();
  }
}
