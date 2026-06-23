import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
part 'player_event.dart';
part 'player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayerRepository _audioPlayerRepository;
  StreamSubscription? _mediaItemSubscription;
  StreamSubscription? _playbackStateSubscription;

  SongsEntity? _currentSong;
  bool _isPlaying = false;
  int? songIndex = -1;

  AudioPlayerBloc({required AudioPlayerRepository audioPlayerRepository})
    : _audioPlayerRepository = audioPlayerRepository,
      super(AudioPlayerIdle()) {
    on<LoadTrackEvent>(_onLoadTrack);
    on<SkipToNextEvent>(_onSkipToNext);
    on<SkipToPreviousEvent>(_onSkipToPrevious);
    on<SeekPositionEvent>(_onSeekPosition);
    on<PlayPausePressedEvent>(_onPlayPausePressed);
    on<UpdateCurrentItemEvent>(_onUpdateCurrentItem);
    on<UpdatePlaybackStateEvent>(_onUpdatePlaybackState);
    initStreamSubscriptions();
  }

  void initStreamSubscriptions() {
    _mediaItemSubscription = _audioPlayerRepository.currentSongStream.listen((
      data,
    ) {
      add(UpdateCurrentItemEvent(newItem: data.song, newIndex: data.index));
    });

    _playbackStateSubscription = _audioPlayerRepository.isPlayingStream.listen((
      isPlaying,
    ) {
      add(UpdatePlaybackStateEvent(playPause: isPlaying));
    });
  }

  Future<void> _onLoadTrack(
    LoadTrackEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    if (songIndex != event.index) {
      songIndex = event.index;
      emit(AudioPlayerLoading());
      await _audioPlayerRepository.loadTrack(event.index);
    }

    if (!_isPlaying) {
      await _audioPlayerRepository.playPause(_isPlaying);
    }
  }

  Future<void> _onSeekPosition(
    SeekPositionEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioPlayerRepository.seek(event.position);
  }

  void _onUpdateCurrentItem(
    UpdateCurrentItemEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    _currentSong = event.newItem;
    songIndex = event.newIndex;

    if (_currentSong == null) {
      emit(AudioPlayerIdle());
      return;
    }

    emit(
      AudioPlayerReady(
        isPlaying: _isPlaying,
        currentItem: _currentSong,
        position: Duration.zero,
      ),
    );
  }

  void _onSkipToNext(
    SkipToNextEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioPlayerRepository.skipToNext();
  }

  void _onSkipToPrevious(
    SkipToPreviousEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioPlayerRepository.skipToPrevious();
  }

  void _onPlayPausePressed(
    PlayPausePressedEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _audioPlayerRepository.playPause(!event.playPause);
  }

  void _onUpdatePlaybackState(
    UpdatePlaybackStateEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    _isPlaying = event.playPause;

    if (state is AudioPlayerLoading) return;

    if (_currentSong == null) {
      emit(AudioPlayerIdle());
      return;
    }
    emit(
      AudioPlayerReady(
        isPlaying: _isPlaying,
        currentItem: _currentSong!,
        position: state is AudioPlayerReady
            ? (state as AudioPlayerReady).position
            : Duration.zero,
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
