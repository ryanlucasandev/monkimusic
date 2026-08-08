part of 'player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

final class SkipToNextEvent extends AudioPlayerEvent {
  const SkipToNextEvent();
}

final class SkipToPreviousEvent extends AudioPlayerEvent {
  const SkipToPreviousEvent();
}

final class LoadTrackEvent extends AudioPlayerEvent {
  final List<SongsEntity> songs;
  final int index;
  const LoadTrackEvent({required this.index, required this.songs});

  @override
  List<Object?> get props => [index, songs];
}

final class SeekPositionEvent extends AudioPlayerEvent {
  final Duration position;
  const SeekPositionEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

final class UpdatePlaybackStateEvent extends AudioPlayerEvent {
  final bool playing;
  const UpdatePlaybackStateEvent({required this.playing});

  @override
  List<Object?> get props => [playing];
}

final class PlayPausePressedEvent extends AudioPlayerEvent {
  final bool playing;
  const PlayPausePressedEvent({required this.playing});

  @override
  List<Object?> get props => [playing];
}

final class ToggleShuffle extends AudioPlayerEvent {
  const ToggleShuffle();
}

final class ShuffleModeChanged extends AudioPlayerEvent {
  final bool enabled;
  const ShuffleModeChanged({required this.enabled});
}

final class UpdateCurrentItemEvent extends AudioPlayerEvent {
  final SongsEntity? newItem;
  final int newIndex;
  const UpdateCurrentItemEvent({required this.newItem, required this.newIndex});
  @override
  List<Object?> get props => [newItem, newIndex];
}
