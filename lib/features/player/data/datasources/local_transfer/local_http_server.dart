import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/transfer_session_model.dart';

class LocalHttpServer {
  HttpServer? _server;

  late TransferSessionModel _session;
  late ShareConnectionModel _connection;

  Future<void> start({
    required TransferSessionModel session,
    required ShareConnectionModel connection,
  }) async {
    _connection = connection;
    _session = session;

    _server = await HttpServer.bind(InternetAddress.anyIPv4, connection.port);

    print('Server started!');
    print('Listening on ${_server!.address.address}:${_server!.port}');

    unawaited(_listen());
  }

  Future<void> _listen() async {
    await for (final request in _server!) {
      await _handleRequest(request);
    }
  }

  Future<void> stop() async {
    print('SERVER: stopping...');
    await _server?.close();
    _server = null;
    print('SERVER: stopped');
  }

  Future<void> _handleRequest(HttpRequest request) async {
    print('INCOMING REQUEST: ${request.method} ${request.uri}');
    if (!_isAuthorized(request)) {
      await _sendError(request, HttpStatus.forbidden, 'Invalid token');
      return;
    }

    switch (request.uri.path) {
      case '/':
        await _sendJson(request, {'message': 'MonkiMusic Local Server'});
        return;

      case '/session':
        print('SESSION REQUEST RECEIVED');

        final data = {
          'sessionId': _session.sessionId,
          'playlist': _session.playlist.toJson(),
          'songs': _session.songs.map((song) => song.toJson()).toList(),
        };

        print('SESSION JSON CREATED');

        await _sendJson(request, data);

        print('SESSION RESPONSE SENT');
        return;

      case '/download':
        print('DOWNLOAD REQUEST: ${request.uri}');

        final songId = int.tryParse(
          request.uri.queryParameters['songId'] ?? '',
        );

        print('REQUEST SONG ID: $songId');

        if (songId == null) {
          await _sendError(request, HttpStatus.badRequest, 'Invalid song id');

          return;
        }

        final song = _session.songs.firstWhere((song) => song.songId == songId);

        print('FOUND SONG: ${song.title}');
        print('FILE PATH: ${song.filePath}');

        if (song.filePath == null) {
          await _sendError(request, HttpStatus.badRequest, 'Song path missing');
          return;
        }

        final file = File(song.filePath!);

        print('FILE EXISTS: ${await file.exists()}');

        if (!await file.exists()) {
          await _sendError(request, HttpStatus.notFound, 'Song file not found');
          return;
        }

        final filename = _sanitizeFilename(song.title ?? 'Unknown Song');

        final downloadName = filename.endsWith('.mp3')
            ? filename
            : '$filename.mp3';

        request.response.headers.contentType = ContentType('audio', 'mpeg');

        request.response.headers.set(
          HttpHeaders.contentDisposition,
          'attachment; filename="$downloadName"',
        );

        request.response.headers.contentLength = await file.length();

        print('SENDING FILE: ${file.path}');
        print('FILE SIZE: ${await file.length()}');

        await file.openRead().pipe(request.response);

        print('FILE SENT');

        return;

      case '/complete':
        await _sendJson(request, {'message': 'Transfer completed'});

        await stop();
        return;

      default:
        await _sendError(request, HttpStatus.notFound, 'Route not found');
    }

    await request.response.close();
  }

  bool _isAuthorized(HttpRequest request) {
    final token = request.uri.queryParameters['token'];
    return token == _connection.token;
  }

  Future<void> _sendError(
    HttpRequest request,
    int statusCode,
    String message,
  ) async {
    request.response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode({'error': message}));

    await request.response.close();
  }

  Future<void> _sendJson(
    HttpRequest request,
    Object? data, {
    int statusCode = HttpStatus.ok,
  }) async {
    request.response
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data));

    await request.response.close();
  }

  String _sanitizeFilename(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }
}
