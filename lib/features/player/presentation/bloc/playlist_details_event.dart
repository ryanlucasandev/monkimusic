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
