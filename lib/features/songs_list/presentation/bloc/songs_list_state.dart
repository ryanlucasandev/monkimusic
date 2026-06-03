part of 'songs_list_bloc.dart';

sealed class SongsListState extends Equatable {
  const SongsListState();

  @override
  List<Object?> get props => [];
}

final class SongsListInitial extends SongsListState {}

final class SongsListLoading extends SongsListState {}

final class SongsListLoaded extends SongsListState {
  const SongsListLoaded({this.allSongs = const <MediaItem>[]});
  final List<MediaItem> allSongs;

  @override
  List<Object?> get props => [allSongs];
}

final class SongsListFailure extends SongsListState {
  final String? errorMessage;
  const SongsListFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
