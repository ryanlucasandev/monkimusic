part of 'songs_bloc.dart';

sealed class SongsEvent extends Equatable {
  const SongsEvent();

  @override
  List<Object?> get props => [];
}

final class SongsFetched extends SongsEvent {
  const SongsFetched();
}
