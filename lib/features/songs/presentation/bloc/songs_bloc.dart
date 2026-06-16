import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/songs/data/datasources/fetch_device_songs_datasource.dart';

part 'songs_state.dart';
part 'songs_event.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final AudioPlayerHandler _audioHandler;

  SongsBloc({required AudioPlayerHandler audioHandler})
    : _audioHandler = audioHandler,
      super(SongsInitial()) {
    on<SongsFetched>(_onSongsListFetched);
  }

  Future<void> _onSongsListFetched(
    SongsFetched event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());

    try {
      final songsValue = await FetchDeviceSongs.execute();
      _audioHandler.initSongs(songs: songsValue);
      emit(SongsLoaded(allSongs: songsValue));
    } catch (_) {
      emit(SongsFailure());
    }
  }
}
