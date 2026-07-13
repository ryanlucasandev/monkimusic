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
  const PlaylistDetailsLoaded({
    this.playlistSongs = const <SongsEntity>[],
    this.isReordering = false,
  });
  final List<SongsEntity> playlistSongs;
  final bool isReordering;

  PlaylistDetailsLoaded copyWith({
    List<SongsEntity>? playlistSongs,
    bool? isReordering,
  }) {
    return PlaylistDetailsLoaded(
      playlistSongs: playlistSongs ?? this.playlistSongs,
      isReordering: isReordering ?? this.isReordering,
    );
  }

  @override
  List<Object?> get props => [playlistSongs, isReordering];
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
