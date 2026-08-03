import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'transfer_state.dart';
part 'transfer_event.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository _transferRepository;

  TransferBloc({required TransferRepository transferRepository})
    : _transferRepository = transferRepository,
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

      for (var i = 0; i < totalSongs; i++) {
        final song = event.session.songs[i];

        try {
          final filePath = await _transferRepository.downloadSong(
            connection: event.connection,
            song: song,
            directory: directory.path,
            onProgress: (progress) {
              print('BLOC PROGRESS: $progress');
              emit(
                TransferDownloading(
                  currentSong: i + 1,
                  totalSongs: totalSongs,
                  currentSongProgress: progress,
                  song: song,
                ),
              );
            },
          );

          if (filePath == null) {
            throw Exception('Failed to download ${song.title}');
          }
        } catch (e) {
          print('FAILED DOWNLOADING ${song.title}: $e');
          continue;
        }
      }

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
