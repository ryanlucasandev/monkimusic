part of 'songs_bloc.dart';

sealed class SongsEvent extends Equatable {
  const SongsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSongs extends SongsEvent {
  const LoadSongs();
}

final class EnterSongSelectionMode extends SongsEvent {
  const EnterSongSelectionMode();
}

final class ExitSongSelectionMode extends SongsEvent {
  const ExitSongSelectionMode();
}

final class ToggleSongSelection extends SongsEvent {
  final SongsEntity song;
  const ToggleSongSelection(this.song);

  @override
  List<Object?> get props => [song];
}
