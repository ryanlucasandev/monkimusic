import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/songs/domain/repositories/songs_repository.dart';

part 'songs_state.dart';
part 'songs_event.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final AudioPlayerHandler _audioHandler;
  final SongsRepository _songsRepository;

  SongsBloc({
    required AudioPlayerHandler audioHandler,
    required SongsRepository songsRepository,
  }) : _audioHandler = audioHandler,
       _songsRepository = songsRepository,
       super(SongsInitial()) {
    on<SongsFetched>(_onSongsListFetched);
  }

  Future<void> _onSongsListFetched(
    SongsFetched event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());

    try {
      // final songsValue = await FetchDeviceSongs.execute();
      final songsValue = await _songsRepository.fetchDeviceSongs();

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
