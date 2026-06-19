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
  final SongsEntity? currentItem;
  final bool isPlaying;
  final Duration position;
  const AudioPlayerReady({
    this.currentItem,
    required this.isPlaying,
    required this.position,
  });

  AudioPlayerReady copyWith({
    SongsEntity? currentItem,
    bool? isPlaying,
    Duration? position,
  }) {
    return AudioPlayerReady(
      isPlaying: isPlaying ?? this.isPlaying,
      currentItem: currentItem ?? this.currentItem,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [isPlaying, currentItem, position];
}

final class AudioPlayerError extends AudioPlayerState {
  final String errorMessage;
  const AudioPlayerError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
