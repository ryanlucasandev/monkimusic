part of 'playlist_bloc.dart';

sealed class PlaylistState extends Equatable {
  const PlaylistState();
  @override
  List<Object?> get props => [];
}

final class PlaylistInitial extends PlaylistState {
  const PlaylistInitial();
}

final class PlaylistLoading extends PlaylistState {
  const PlaylistLoading();
}

final class PlaylistLoaded extends PlaylistState {
  final List<PlaylistsEntity> playlists;
  const PlaylistLoaded(this.playlists);

  @override
  List<Object?> get props => [playlists];
}

final class PlaylistEmpty extends PlaylistState {
  const PlaylistEmpty();
}

final class PlaylistFailure extends PlaylistState {
  final String message;
  const PlaylistFailure(this.message);

  @override
  List<Object?> get props => [message];
}
