part of 'playlist_details_bloc.dart';

sealed class PlaylistDetailsEvent extends Equatable {
  const PlaylistDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPlaylistSongs extends PlaylistDetailsEvent {
  final PlaylistsEntity playlist;
  const LoadPlaylistSongs({required this.playlist});

  @override
  List<Object?> get props => [playlist];
}

final class RemoveSongFromPlaylist extends PlaylistDetailsEvent {
  final PlaylistsEntity playlist;
  final int songId;

  const RemoveSongFromPlaylist({required this.playlist, required this.songId});

  @override
  List<Object?> get props => [playlist, songId];
}

final class RemoveMultipleSongsFromPlaylist extends PlaylistDetailsEvent {
  final PlaylistsEntity playlist;
  final Set<int> songIds;

  const RemoveMultipleSongsFromPlaylist({
    required this.playlist,
    required this.songIds,
  });

  @override
  List<Object?> get props => [playlist, songIds];
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

final class SearchChanged extends PlaylistDetailsEvent {
  final String query;
  const SearchChanged(this.query);
}

final class SharePlaylist extends PlaylistDetailsEvent {
  const SharePlaylist();
}
