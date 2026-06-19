part of 'player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTrackEvent extends AudioPlayerEvent {
  final int index;
  const LoadTrackEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

final class UpdateCurrentItemEvent extends AudioPlayerEvent {
  final SongsEntity? newItem;
  const UpdateCurrentItemEvent({required this.newItem});
  @override
  List<Object?> get props => [newItem];
}

final class SeekPositionEvent extends AudioPlayerEvent {
  final Duration position;
  const SeekPositionEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

final class UpdatePlaybackStateEvent extends AudioPlayerEvent {
  final bool isPlaying;
  const UpdatePlaybackStateEvent({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}

final class PlayPausePressedEvent extends AudioPlayerEvent {
  final bool isPlaying;
  const PlayPausePressedEvent({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}

final class SkipToNextEvent extends AudioPlayerEvent {
  const SkipToNextEvent();
}

final class SkipToPreviousEvent extends AudioPlayerEvent {
  const SkipToPreviousEvent();
}
