part of 'songs_list_bloc.dart';

sealed class SongsListEvent extends Equatable {
  const SongsListEvent();

  @override
  List<Object?> get props => [];
}

final class SongsListFetched extends SongsListEvent {
  const SongsListFetched();
}
