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
  const CreatePlaylist({required this.name});

  @override
  List<Object?> get props => [name];
}

final class RenamePlaylist extends PlaylistEvent {
  final String name;
  final int id;
  const RenamePlaylist({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];
}

final class DeletePlaylist extends PlaylistEvent {
  final int id;
  const DeletePlaylist({required this.id});

  @override
  List<Object?> get props => [id];
}

final class PlaylistOpened extends PlaylistEvent {
  final int id;
  const PlaylistOpened(this.id);

  @override
  List<Object?> get props => [id];
}

final class AddSongToPlaylist extends PlaylistEvent {
  final int playlistId;
  final SongsEntity song;

  const AddSongToPlaylist({required this.playlistId, required this.song});

  @override
  List<Object?> get props => [playlistId, song];
}

final class AddMultipleSongsToPlaylist extends PlaylistEvent {
  final int playlistId;
  final Set<SongsEntity> songs;

  const AddMultipleSongsToPlaylist({
    required this.playlistId,
    required this.songs,
  });

  @override
  List<Object?> get props => [songs];
}
