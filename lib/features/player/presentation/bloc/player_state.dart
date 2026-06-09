part of 'player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AudioPlayerIdle extends AudioPlayerState {}

final class AudioPlayerLoading extends AudioPlayerState {}

final class AudioPlayerReady extends AudioPlayerState {
  final MediaItem? currentItem;
  final bool isPlaying;
  AudioPlayerReady({this.currentItem, required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying, currentItem];
}

final class AudioPlayerError extends AudioPlayerState {
  final String errorMessage;
  AudioPlayerError(this.errorMessage);
}
