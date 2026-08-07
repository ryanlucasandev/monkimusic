part of 'playlist_details_bloc.dart';

sealed class PlaylistDetailsState extends Equatable {
  const PlaylistDetailsState();

  @override
  List<Object?> get props => [];
}

final class PlaylistDetailsInitial extends PlaylistDetailsState {
  const PlaylistDetailsInitial();
}

final class PlaylistDetailsLoading extends PlaylistDetailsState {
  const PlaylistDetailsLoading();
}

final class PlaylistDetailsLoaded extends PlaylistDetailsState {
  final PlaylistsEntity playlist;
  final List<SongsEntity> playlistSongs;
  final List<SongsEntity> filteredSongs;
  final bool isReordering;
  final bool isSelectingSongs;
  final Set<int> selectedSongIds;
  final String searchQuery;

  const PlaylistDetailsLoaded({
    required this.playlist,
    this.playlistSongs = const <SongsEntity>[],
    this.filteredSongs = const <SongsEntity>[],
    this.isReordering = false,
    this.isSelectingSongs = false,
    this.selectedSongIds = const {},
    this.searchQuery = '',
  });

  PlaylistDetailsLoaded copyWith({
    PlaylistsEntity? playlist,
    List<SongsEntity>? playlistSongs,
    List<SongsEntity>? filteredSongs,
    bool? isReordering,
    bool? isSelectingSongs,
    Set<int>? selectedSongIds,
    String? searchQuery,
  }) {
    return PlaylistDetailsLoaded(
      playlist: playlist ?? this.playlist,
      playlistSongs: playlistSongs ?? this.playlistSongs,
      filteredSongs: filteredSongs ?? this.filteredSongs,
      isReordering: isReordering ?? this.isReordering,
      isSelectingSongs: isSelectingSongs ?? this.isSelectingSongs,
      selectedSongIds: selectedSongIds ?? this.selectedSongIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    playlistSongs,
    filteredSongs,
    isReordering,
    isSelectingSongs,
    selectedSongIds,
    searchQuery,
  ];
}

final class PlaylistDetailsEmpty extends PlaylistDetailsState {
  const PlaylistDetailsEmpty();
}

final class PlaylistDetailsFailure extends PlaylistDetailsState {
  final String? errorMessage;
  const PlaylistDetailsFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class PlaylistShareReady extends PlaylistDetailsState {
  final TransferSessionEntity session;
  final ShareConnectionEntity connection;
  const PlaylistShareReady(this.session, this.connection);
}
