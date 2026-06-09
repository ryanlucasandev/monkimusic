part of 'player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
  @override
  List<Object?> get props => [];
}

final class AudioPlayerIdle extends AudioPlayerState {
  const AudioPlayerIdle();
}

final class AudioPlayerLoading extends AudioPlayerState {
  const AudioPlayerLoading();
}

final class AudioPlayerReady extends AudioPlayerState {
  final MediaItem? currentItem;
  final bool isPlaying;
  const AudioPlayerReady({this.currentItem, required this.isPlaying});

  AudioPlayerReady copyWith({MediaItem? currentItem, bool? isPlaying}) {
    return AudioPlayerReady(
      isPlaying: isPlaying ?? this.isPlaying,
      currentItem: this.currentItem,
    );
  }

  @override
  List<Object?> get props => [isPlaying, currentItem];
}

final class AudioPlayerError extends AudioPlayerState {
  final String errorMessage;
  const AudioPlayerError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
