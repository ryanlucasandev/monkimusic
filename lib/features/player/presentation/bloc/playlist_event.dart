part of 'playlist_bloc.dart';

sealed class PlaylistEvent extends Equatable {
  const PlaylistEvent();
  @override
  List<Object?> get props => [];
}

final class LoadPlaylists extends PlaylistEvent {
  const LoadPlaylists();
}

final class CreatePlaylist extends PlaylistEvent {
  final String name;
  const CreatePlaylist(this.name);

  @override
  List<Object?> get props => [name];
}

final class DeletePlaylist extends PlaylistEvent {
  final int id;
  const DeletePlaylist(this.id);

  @override
  List<Object?> get props => [id];
}

final class PlaylistOpened extends PlaylistEvent {
  final int id;
  const PlaylistOpened(this.id);

  @override
  List<Object?> get props => [id];
}

final class SongAddedToPlaylist extends PlaylistEvent {
  final int playlistId;
  const SongAddedToPlaylist(this.playlistId);

  @override
  List<Object?> get props => [playlistId];
}
