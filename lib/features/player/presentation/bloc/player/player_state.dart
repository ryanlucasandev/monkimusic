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
  final bool isPlaying;
  final Duration position;
  final SongsEntity? currentItem;
  final bool isShuffleEnabled;
  const AudioPlayerReady({
    required this.isPlaying,
    required this.position,
    this.currentItem,
    this.isShuffleEnabled = false,
  });

  AudioPlayerReady copyWith({
    bool? isPlaying,
    Duration? position,
    SongsEntity? currentItem,
    bool? isShuffleEnabled,
  }) {
    return AudioPlayerReady(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      currentItem: currentItem ?? this.currentItem,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
    );
  }

  @override
  List<Object?> get props => [
    isPlaying,
    position,
    currentItem,
    isShuffleEnabled,
  ];
}

final class AudioPlayerError extends AudioPlayerState {
  final String errorMessage;
  const AudioPlayerError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
