import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/player/domain/usecases/init_songs_usecase.dart';
import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';
import 'package:monkimusic/features/songs/domain/usecases/fetch_device_songs.dart';

part 'songs_state.dart';
part 'songs_event.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final AudioPlayerHandler _audioHandler;
  final FetchDeviceSongs _fetchDeviceSongs;
  final InitSongsUsecase _initSongsUsecase;

  SongsBloc({
    required AudioPlayerHandler audioHandler,
    required FetchDeviceSongs fetchDeviceSongs,
    required InitSongsUsecase initSongsUsecase,
  }) : _audioHandler = audioHandler,
       _fetchDeviceSongs = fetchDeviceSongs,
       _initSongsUsecase = initSongsUsecase,
       super(SongsInitial()) {
    on<LoadSongs>(_onSongsListFetched);
  }

  Future<void> _onSongsListFetched(
    LoadSongs event,
    Emitter<SongsState> emit,
  ) async {
    emit(SongsLoading());

    try {
      final songs = await _fetchDeviceSongs(NoParams());

      if (songs.isNotEmpty) {
        await _initSongsUsecase.call(songs);
        emit(SongsLoaded(allSongs: songs));
      }
    } catch (_) {
      emit(SongsFailure());
    }
  }
}
