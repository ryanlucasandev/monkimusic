import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/server_events/transfer_server_event.dart';

abstract class TransferRepository {
  Future<void> startServer({
    required TransferSessionEntity session,
    required ShareConnectionEntity connection,
  });
  Future<TransferSessionEntity> fetchTransferSession(
    ShareConnectionEntity connection,
  );
  Future<String?> downloadSong({
    required ShareConnectionEntity connection,
    required SongsEntity song,
    required String directory,
    void Function(double progress)? onProgress,
  });

  Future<void> transferComplete(ShareConnectionEntity connection);
  Future<void> transferCancel(ShareConnectionEntity connection);
  Future<void> receiverConnected(ShareConnectionEntity connection);
  Future<void> receiverDisconnected(ShareConnectionEntity connection);
  Future<void> songDownloadCompleted(
    ShareConnectionEntity connection,
    int songId,
  );
  Stream<SenderServerEvent> get transferEvents;
}
