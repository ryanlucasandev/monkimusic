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
  final List<SongsEntity> playlistSongs;
  final bool isReordering;
  final bool isSelectingSongs;
  final Set<int> selectedSongIds;

  const PlaylistDetailsLoaded({
    this.playlistSongs = const <SongsEntity>[],
    this.isReordering = false,
    this.isSelectingSongs = false,
    this.selectedSongIds = const {},
  });

  PlaylistDetailsLoaded copyWith({
    List<SongsEntity>? playlistSongs,
    bool? isReordering,
    bool? isSelectingSongs,
    Set<int>? selectedSongIds,
  }) {
    return PlaylistDetailsLoaded(
      playlistSongs: playlistSongs ?? this.playlistSongs,
      isReordering: isReordering ?? this.isReordering,
      isSelectingSongs: isSelectingSongs ?? this.isSelectingSongs,
      selectedSongIds: selectedSongIds ?? this.selectedSongIds,
    );
  }

  @override
  List<Object?> get props => [
    playlistSongs,
    isReordering,
    isSelectingSongs,
    selectedSongIds,
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
