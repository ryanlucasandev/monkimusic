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
  final int index;
  const LoadTrackEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

final class SeekPositionEvent extends AudioPlayerEvent {
  final Duration position;
  const SeekPositionEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

final class UpdatePlaybackStateEvent extends AudioPlayerEvent {
  final bool playPause;
  const UpdatePlaybackStateEvent({required this.playPause});

  @override
  List<Object?> get props => [playPause];
}

final class PlayPausePressedEvent extends AudioPlayerEvent {
  final bool playPause;
  const PlayPausePressedEvent({required this.playPause});

  @override
  List<Object?> get props => [playPause];
}

final class UpdateCurrentItemEvent extends AudioPlayerEvent {
  final SongsEntity? newItem;
  final int newIndex;
  const UpdateCurrentItemEvent({required this.newItem, required this.newIndex});
  @override
  List<Object?> get props => [newItem, newIndex];
}
