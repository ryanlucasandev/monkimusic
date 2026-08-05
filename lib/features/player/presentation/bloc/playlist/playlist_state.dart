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
  final String? errorMessage;
  const PlaylistLoaded({required this.playlists, this.errorMessage});

  PlaylistLoaded copyWith({
    List<PlaylistsEntity>? playlists,
    String? errorMessage,
  }) {
    return PlaylistLoaded(
      playlists: playlists ?? this.playlists,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [playlists, errorMessage];
}

final class PlaylistCreated extends PlaylistState {
  const PlaylistCreated();
}

final class PlaylistEmpty extends PlaylistState {
  const PlaylistEmpty();
}

final class PlaylistFailure extends PlaylistState {
  final String errorMessage;
  const PlaylistFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class AddMultipleSongsSuccess extends PlaylistState {
  const AddMultipleSongsSuccess();
}

final class AddMultipleSongsFailure extends PlaylistState {
  final String message;
  const AddMultipleSongsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
