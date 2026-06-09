import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/songs_list/data/datasources/fetch_device_songs_datasource.dart';

part 'songs_list_state.dart';
part 'songs_list_event.dart';

class SongsListBloc extends Bloc<SongsListEvent, SongsListState> {
  final AudioPlayerHandler _audioHandler;

  SongsListBloc({required AudioPlayerHandler audioHandler})
    : _audioHandler = audioHandler,
      super(SongsListInitial()) {
    on<SongsListFetched>(_onSongsListFetched);
  }

  Future<void> _onSongsListFetched(
    SongsListFetched event,
    Emitter<SongsListState> emit,
  ) async {
    emit(SongsListLoading());

    try {
      final songsValue = await FetchDeviceSongs.execute();
      _audioHandler.initSongs(songs: songsValue);
      emit(SongsListLoaded(allSongs: songsValue));
    } catch (_) {
      emit(SongsListFailure());
    }
  }
}
