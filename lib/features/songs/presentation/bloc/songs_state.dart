part of 'songs_bloc.dart';

sealed class SongsState extends Equatable {
  const SongsState();

  @override
  List<Object?> get props => [];
}

final class SongsInitial extends SongsState {
  const SongsInitial();
}

final class SongsLoading extends SongsState {
  const SongsLoading();
}

final class SongsLoaded extends SongsState {
  const SongsLoaded({this.allSongs = const <MediaItem>[]});
  final List<MediaItem> allSongs;

  @override
  List<Object?> get props => [allSongs];
}

final class SongsFailure extends SongsState {
  final String? errorMessage;
  const SongsFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
