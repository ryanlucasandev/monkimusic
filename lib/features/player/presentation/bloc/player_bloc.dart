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
  StreamSubscription? _playbackStateSubscription;

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

    _playbackStateSubscription = _audioHandler.playbackState.listen((state) {
      add(UpdatePlaybackStateEvent(state: state));
    });
  }

  Future<void> _onLoadTrack(
    LoadTrackEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(AudioPlayerLoading());
    _audioHandler.skiptoQueueItem(event.index);
  }

  void _onUpdateCurrentItem(
    UpdateCurrentItemEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    if (event.newItem == null) {
      emit(AudioPlayerIdle());
      return;
    }
    final isPlaying = state is AudioPlayerReady
        ? (state as AudioPlayerReady).isPlaying
        : false;

    emit(AudioPlayerReady(isPlaying: isPlaying, currentItem: event.newItem));
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
    if (event.isPlaying) {
      _audioHandler.pause();
    } else {
      _audioHandler.play();
    }
  }

  void _onUpdatePlaybackState(
    UpdatePlaybackStateEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    final processingState = event.state.processingState;

    if (processingState == AudioProcessingState.idle ||
        processingState == AudioProcessingState.completed) {
      emit(AudioPlayerIdle());
      return;
    }

    final isPlaying = event.state.playing;

    emit(
      AudioPlayerReady(
        isPlaying: isPlaying,
        currentItem: _audioHandler.mediaItem.value,
      ),
    );
  }

  @override
  Future<void> close() {
    _mediaItemSubscription?.cancel();
    _playbackStateSubscription?.cancel();
    return super.close();
  }
}
