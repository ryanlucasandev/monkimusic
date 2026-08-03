import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'transfer_state.dart';
part 'transfer_event.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository _transferRepository;
  final PlaylistsRepository _playlistsRepository;

  TransferBloc({
    required TransferRepository transferRepository,
    required PlaylistsRepository playlistRepository,
  }) : _transferRepository = transferRepository,
       _playlistsRepository = playlistRepository,
       super(TransferInitial()) {
    on<ConnectToSender>(_onConnectToSender);
    on<StartDownload>(_onStartDownload);
  }

  Future<void> _onStartDownload(
    StartDownload event,
    Emitter<TransferState> emit,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final totalSongs = event.session.songs.length;
      final downloadedSongs = <SongsEntity>[];

      for (var i = 0; i < totalSongs; i++) {
        final song = event.session.songs[i];

        try {
          final filePath = await _transferRepository.downloadSong(
            connection: event.connection,
            song: song,
            directory: directory.path,
            onProgress: (progress) {
              if (!emit.isDone) {
                print('BLOC PROGRESS: $progress');
                emit(
                  TransferDownloading(
                    currentSong: i + 1,
                    totalSongs: totalSongs,
                    currentSongProgress: progress,
                    song: song,
                  ),
                );
              }
            },
          );

          if (filePath == null) {
            throw Exception('Failed to download ${song.title}');
          }

          downloadedSongs.add(song.copyWith(id: filePath, filePath: filePath));
        } catch (e) {
          print('FAILED DOWNLOADING ${song.title}: $e');
          continue;
        }
      }

      await _playlistsRepository.importPlaylist(
        event.session.playlist,
        downloadedSongs,
      );

      emit(TransferCompleted());
    } catch (e) {
      emit(TransferFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onConnectToSender(
    ConnectToSender event,
    Emitter<TransferState> emit,
  ) async {
    try {
      emit(TransferConnecting());

      final session = await _transferRepository.fetchTransferSession(
        event.connection,
      );

      emit(TransferConnected(session: session));
    } catch (e) {
      emit(TransferFailure(errorMessage: e.toString()));
    }
  }
}
