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
  final List<PlaylistsEntity> filteredPlaylists;
  final String errorMessage;
  final String searchQuery;

  const PlaylistLoaded({
    required this.playlists,
    this.filteredPlaylists = const <PlaylistsEntity>[],
    this.errorMessage = '',
    this.searchQuery = '',
  });

  PlaylistLoaded copyWith({
    List<PlaylistsEntity>? playlists,
    List<PlaylistsEntity>? filteredPlaylists,
    String? errorMessage,
    String? searchQuery,
  }) {
    return PlaylistLoaded(
      playlists: playlists ?? this.playlists,
      filteredPlaylists: filteredPlaylists ?? this.filteredPlaylists,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    playlists,
    filteredPlaylists,
    errorMessage,
    searchQuery,
  ];
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
