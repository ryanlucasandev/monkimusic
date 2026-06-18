import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/songs/domain/usecases/fetch_device_songs.dart';

part 'songs_state.dart';
part 'songs_event.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final AudioPlayerHandler _audioHandler;
  final FetchDeviceSongs _fetchDeviceSongs;

  SongsBloc({
    required AudioPlayerHandler audioHandler,
    required FetchDeviceSongs fetchDeviceSongs,
  }) : _audioHandler = audioHandler,
       _fetchDeviceSongs = fetchDeviceSongs,
       super(SongsInitial()) {
    on<LoadSongs>(_onSongsListFetched);
  }

  Future<void> _onSongsListFetched(
    LoadSongs event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());

    try {
      final songsValue = await _fetchDeviceSongs(NoParams());

      if (songsValue.isNotEmpty) {
        final songs = songsValue.map((song) {
          return MediaItem(
            id: song.id,
            title: song.title,
            artist: song.artist,
            duration: song.duration,
          );
        }).toList();
        await _audioHandler.initSongs(songs: songs);
        emit(SongsLoaded(allSongs: songs));
      }
    } catch (_) {
      emit(SongsFailure());
    }
  }
}
