import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/transfer_session_model.dart';

class LocalTransferClient {
  final HttpClient _client = HttpClient();

  Future<TransferSessionModel> fetchTransferSession(
    ShareConnectionModel connection,
  ) async {
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

  Future<File> downloadSong(
    ShareConnectionModel connection,
    SongsModel song,
    Directory saveDirectory, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      if (!await saveDirectory.exists()) {
        await saveDirectory.create(recursive: true);
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

      final file = File('${saveDirectory.path}/$filename');

      final sink = file.openWrite();

      final totalBytes = response.contentLength;

      var receivedBytes = 0;

      await for (final chunk in response) {
        sink.add(chunk);

        receivedBytes += chunk.length;

        if (totalBytes > 0) {
          onProgress?.call(receivedBytes / totalBytes);
        }
      }

      await sink.close();

      onProgress?.call(1.0);

      return file;
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

  void dispose() {
    _client.close();
  }
}
