part of 'player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadTrackEvent extends AudioPlayerEvent {
  final int index;
  final MediaItem item;
  LoadTrackEvent({required this.index, required this.item});
}

final class UpdateCurrentItemEvent extends AudioPlayerEvent {
  final MediaItem? newItem;
  UpdateCurrentItemEvent({required this.newItem});
}

final class UpdatePlaybackStateEvent extends AudioPlayerEvent {
  final bool isPlaying;
  UpdatePlaybackStateEvent({required this.isPlaying});
}

final class PlayPausePressedEvent extends AudioPlayerEvent {
  final bool isPlaying;
  PlayPausePressedEvent({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}

final class SkipToNextEvent extends AudioPlayerEvent {}

final class SkipToPreviousEvent extends AudioPlayerEvent {}
