import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';

part 'player_event.dart';
part 'player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayerHandler _audioHandler;
  StreamSubscription? _mediaItemSubscription;
  StreamSubscription? _playBackStateSubscription;

  AudioPlayerBloc({required AudioPlayerHandler audioHandler})
    : _audioHandler = audioHandler,
      super(AudioPlayerIdle()) {
    on<LoadTrackEvent>(_onLoadTrack);
    on<UpdateCurrentItemEvent>(_onUpdateCurrentItem);
    on<UpdatePlaybackStateEvent>(_onUpdatePlaybackState);
    on<PlayPausePressedEvent>(_onPlayPausePressed);
    on<SkipToNextEvent>(_onSkipToNext);
    on<SkipToPreviousEvent>(_onSkipToPrevious);

    // Listen to the audio handler stream behind the scenes
    _mediaItemSubscription = _audioHandler.mediaItem
        .map((item) => item?.id)
        .distinct()
        .listen((_) {
          add(UpdateCurrentItemEvent(newItem: _audioHandler.mediaItem.value));
        });

    _playBackStateSubscription = _audioHandler.playbackState
        .map(
          (state) =>
              state.playing &&
              state.processingState != AudioProcessingState.completed,
        )
        .distinct()
        .listen((state) {
          add(UpdatePlaybackStateEvent(isPlaying: state));
        });
  }

  Future<void> _onLoadTrack(
    LoadTrackEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    _audioHandler.skiptoQueueItem(event.index);
  }

  void _onUpdateCurrentItem(
    UpdateCurrentItemEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    if (state is AudioPlayerReady) {
      final currentState = state as AudioPlayerReady;
      emit(AudioPlayerLoading());
      emit(
        AudioPlayerReady(
          isPlaying: currentState.isPlaying,
          currentItem: event.newItem,
        ),
      );
    } else {
      emit(AudioPlayerLoading());
      emit(AudioPlayerReady(isPlaying: false, currentItem: event.newItem));
    }
  }

  void _onSkipToNext(SkipToNextEvent event, Emitter<AudioPlayerState> emit) {
    _audioHandler.skipToNext();
  }

  void _onSkipToPrevious(
    SkipToPreviousEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    _audioHandler.skipToPrevious();
  }

  void _onPlayPausePressed(
    PlayPausePressedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (state is AudioPlayerReady) {
      if (event.isPlaying) {
        _audioHandler.pause();
      } else {
        _audioHandler.play();
      }
    }
  }

  void _onUpdatePlaybackState(
    UpdatePlaybackStateEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    final currentState = state as AudioPlayerReady;
    emit(
      AudioPlayerReady(
        isPlaying: event.isPlaying,
        currentItem: currentState.currentItem,
      ),
    );
  }

  @override
  Future<void> close() {
    _mediaItemSubscription?.cancel();
    _playBackStateSubscription?.cancel();
    return super.close();
  }
}
