import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:monkimusic/features/player/domain/server_events/transfer_server_event.dart';
import 'package:path_provider/path_provider.dart';

part 'transfer_state.dart';
part 'transfer_event.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository _transferRepository;
  final PlaylistsRepository _playlistsRepository;
  final TransferSessionEntity? session;
  StreamSubscription<TransferServerEvent>? _transferEventSubscription;

  TransferBloc({
    required TransferRepository transferRepository,
    required PlaylistsRepository playlistRepository,
    this.session,
  }) : _transferRepository = transferRepository,
       _playlistsRepository = playlistRepository,
       super(TransferInitialState(session: session)) {
    on<ConnectToSenderEvent>(_onConnectToSender);
    on<StartDownloadEvent>(_onStartDownload);
    on<CancelTransferEvent>(_onCancelTransfer);
    on<ReceiverConnectedEvent>(_onReceiverConnected);
    on<TransferCompletedEvent>(_onTransferCompletedEvent);
    on<TransferCancelledEvent>(_onTransferCancelledEvent);
    on<SongCompletedEvent>(_onSongCompletedEvent);
    _transferEventSubscription = _transferRepository.transferEvents.listen((
      event,
    ) {
      switch (event) {
        case ReceiverConnected():
          add(ReceiverConnectedEvent());
          break;

        case SongCompleted(:final songId):
          add(SongCompletedEvent(songId));
          break;

        case TransferCompleted():
          add(TransferCompletedEvent());
          break;

        case TransferCancelled():
          add(TransferCancelledEvent());
          break;
      }
    });
  }

  Future<void> _onSongCompletedEvent(
    SongCompletedEvent event,
    Emitter<TransferState> emit,
  ) async {
    final currentState = state;

    if (currentState is ReceiverConnectedState) {
      emit(
        SenderProgressState(
          session: currentState.session,
          completedSongs: 1,
          currentSongId: event.songId,
        ),
      );
      return;
    }

    if (currentState is! SenderProgressState) return;

    emit(
      SenderProgressState(
        session: currentState.session,
        completedSongs: currentState.completedSongs + 1,
        currentSongId: event.songId,
      ),
    );
  }

  Future<void> _onReceiverConnected(
    ReceiverConnectedEvent event,
    Emitter<TransferState> emit,
  ) async {
    final session = this.session;

    if (session == null) {
      emit(TransferFailedState(errorMessage: 'Transfer session is missing.'));
      return;
    }

    emit(ReceiverConnectedState(session: session));
  }

  Future<void> _onTransferCancelledEvent(
    TransferCancelledEvent event,
    Emitter<TransferState> emit,
  ) async {
    emit(TransferCancelledState());
  }

  Future<void> _onTransferCompletedEvent(
    TransferCompletedEvent event,
    Emitter<TransferState> emit,
  ) async {
    emit(TransferCompletedState());
  }

  Future<void> _onCancelTransfer(
    CancelTransferEvent event,
    Emitter<TransferState> emit,
  ) async {
    try {
      await _transferRepository.transferCancel(event.connection);
      emit(const TransferCancelledState());
    } catch (e) {
      emit(TransferFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onStartDownload(
    StartDownloadEvent event,
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
                // print('BLOC PROGRESS: $progress');
                emit(
                  ReceiverProgressState(
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

          print('DOWNLOAD SUCCESS: ${song.title}');

          await _transferRepository.songDownloadCompleted(
            event.connection,
            song.songId!,
          );

          print('NOTIFYING SONG COMPLETED: ${song.title}');
          print('SONG ID: ${song.songId}');

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
      await _transferRepository.transferComplete(event.connection);
      emit(TransferCompletedState());
    } catch (e) {
      emit(TransferFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onConnectToSender(
    ConnectToSenderEvent event,
    Emitter<TransferState> emit,
  ) async {
    try {
      emit(ReceiverConnectingState());

      final session = await _transferRepository.fetchTransferSession(
        event.connection,
      );

      await _transferRepository.receiverConnected(event.connection);
      emit(ReceiverConnectedState(session: session));
    } catch (e) {
      emit(TransferFailedState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _transferEventSubscription?.cancel();
    return super.close();
  }
}
