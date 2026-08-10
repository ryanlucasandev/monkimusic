import 'dart:io';

import 'package:monkimusic/features/player/data/datasources/local_transfer/local_http_server.dart';
import 'package:monkimusic/features/player/data/datasources/local_transfer/local_transfer_client.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/transfer_session_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final LocalHttpServer _server;
  final LocalTransferClient _client;

  TransferRepositoryImpl(this._server, this._client);

  @override
  Future<TransferSessionEntity> fetchTransferSession(
    ShareConnectionEntity connection,
  ) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);
    final model = await _client.fetchTransferSession(connectionModel);

    return model.toEntity();
  }

  @override
  Future<void> startServer({
    required TransferSessionEntity session,
    required ShareConnectionEntity connection,
  }) async {
    await _server.start(
      session: TransferSessionModel.fromEntity(session),
      connection: ShareConnectionModel.fromEntity(connection),
    );
  }

  @override
  Future<String?> downloadSong({
    required ShareConnectionEntity connection,
    required SongsEntity song,
    required String directory,
    void Function(double progress)? onProgress,
  }) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);
    final songModel = SongsModel.fromEntity(song);
    final saveDirectory = Directory(directory);

    final uri = await _client.downloadSong(
      connectionModel,
      songModel,
      saveDirectory,
      onProgress: onProgress,
    );

    return uri;
  }

  @override
  Future<void> transferComplete(ShareConnectionEntity connection) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);
    await _client.transferComplete(connectionModel);
  }

  @override
  Future<void> transferCancel(ShareConnectionEntity connection) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);
    await _client.transferCancel(connectionModel);
  }
}
