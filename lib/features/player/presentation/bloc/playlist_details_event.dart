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

final class ReorderPlaylistSongs extends PlaylistDetailsEvent {
  const ReorderPlaylistSongs();
}

final class SavePlaylistOrder extends PlaylistDetailsEvent {
  final int playlistId;
  final List<int> songIds;

  const SavePlaylistOrder({required this.playlistId, required this.songIds});

  @override
  List<Object?> get props => [playlistId, songIds];
}

final class SharePlaylist extends PlaylistDetailsEvent {
  const SharePlaylist();
}
