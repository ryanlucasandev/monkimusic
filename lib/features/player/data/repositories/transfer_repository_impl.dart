import 'dart:io';

import 'package:monkimusic/features/player/data/datasources/local_transfer/local_http_server.dart';
import 'package:monkimusic/features/player/data/datasources/local_transfer/local_transfer_client.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/transfer_session_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/file_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final LocalHttpServer server;
  final LocalTransferClient client;

  TransferRepositoryImpl({required this.server, required this.client});

  @override
  Future<TransferSessionEntity> fetchTransferSession(
    ShareConnectionEntity connection,
  ) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);
    final model = await client.fetchTransferSession(connectionModel);

    return model.toEntity();
  }

  @override
  Future<void> startServer({
    required TransferSessionEntity session,
    required ShareConnectionEntity connection,
  }) async {
    await server.start(
      session: TransferSessionModel.fromEntity(session),
      connection: ShareConnectionModel.fromEntity(connection),
    );
  }

  @override
  Future<FileEntity> downloadSong({
    required ShareConnectionEntity connection,
    required SongsEntity song,
    required String savePath,
  }) async {
    final connectionModel = ShareConnectionModel.fromEntity(connection);

    final songModel = SongsModel.fromEntity(song);

    final saveDirectory = Directory(savePath);

    final file = await client.downloadSong(
      connectionModel,
      songModel,
      saveDirectory,
    );

    return FileEntity(path: file.path, name: file.uri.pathSegments.last);
  }
}
