part of 'playlist_details_bloc.dart';

sealed class PlaylistDetailsEvent extends Equatable {
  const PlaylistDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPlaylistSongs extends PlaylistDetailsEvent {
  final int playlistId;
  const LoadPlaylistSongs({required this.playlistId});

  @override
  List<Object?> get props => [playlistId];
}

final class RemoveSongFromPlaylist extends PlaylistDetailsEvent {
  final int playlistId;
  final int songId;

  const RemoveSongFromPlaylist({
    required this.playlistId,
    required this.songId,
  });

  @override
  List<Object?> get props => [playlistId, songId];
}

final class RemoveMultipleSongsFromPlaylist extends PlaylistDetailsEvent {
  final int playlistId;
  final Set<int> songIds;

  const RemoveMultipleSongsFromPlaylist({
    required this.playlistId,
    required this.songIds,
  });

  @override
  List<Object?> get props => [playlistId, songIds];
}

final class ReorderPlaylistSongs extends PlaylistDetailsEvent {
  const ReorderPlaylistSongs();
}

final class ExitSongSelectionMode extends PlaylistDetailsEvent {
  const ExitSongSelectionMode();
}

final class EnterSongSelectionMode extends PlaylistDetailsEvent {
  const EnterSongSelectionMode();
}

final class ToggleSongSelection extends PlaylistDetailsEvent {
  final int songId;
  const ToggleSongSelection(this.songId);
}

final class SavePlaylistOrder extends PlaylistDetailsEvent {
  final int playlistId;
  final List<int> songIds;

  const SavePlaylistOrder({required this.playlistId, required this.songIds});

  @override
  List<Object?> get props => [playlistId, songIds];
}
