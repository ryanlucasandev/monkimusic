import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/core/utils/search_utils.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/usecases/fetch_device_songs_usecase.dart';

part 'songs_state.dart';
part 'songs_event.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final FetchDeviceSongsUseCase _fetchDeviceSongs;

  SongsBloc({required FetchDeviceSongsUseCase fetchDeviceSongs})
    : _fetchDeviceSongs = fetchDeviceSongs,
      super(SongsInitial()) {
    on<LoadSongs>(_onLoadSongs);
    on<EnterSongSelectionMode>(_onEnterSongSelectionMode);
    on<ExitSongSelectionMode>(_onExitSongSelectionMode);
    on<ToggleSongSelection>(_onToggleSongSelection);
    on<SearchChanged>(_onSearchChanged);
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<SongsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SongsLoaded) return;
    final query = normalizeSearch(event.query);

    if (query.isEmpty) {
      emit(
        currentState.copyWith(
          filteredSongs: currentState.allSongs,
          searchQuery: '',
        ),
      );
      return;
    }

    final filteredSongs = currentState.allSongs.where((song) {
      final title = normalizeSearch(song.title ?? '');
      final album = normalizeSearch(song.album ?? '');
      final artist = normalizeSearch(song.artist ?? '');

      return title.contains(query) ||
          album.contains(query) ||
          artist.contains(query);
    }).toList();

    emit(
      currentState.copyWith(
        filteredSongs: filteredSongs,
        searchQuery: event.query,
      ),
    );
  }

  Future<void> _onLoadSongs(LoadSongs event, Emitter<SongsState> emit) async {
    emit(SongsLoading());

    try {
      final songs = await _fetchDeviceSongs(NoParams());

      if (songs.isEmpty) {
        emit(SongsEmpty());
        return;
      }

      emit(SongsLoaded(allSongs: songs, filteredSongs: songs));
    } catch (_) {
      emit(SongsFailure());
    }
  }

  Future<void> _onEnterSongSelectionMode(
    EnterSongSelectionMode event,
    Emitter<SongsState> emit,
  ) async {
    if (state is SongsLoaded) {
      final currentState = state as SongsLoaded;
      emit(currentState.copyWith(isSelectingSongs: true));
    }
  }

  Future<void> _onExitSongSelectionMode(
    ExitSongSelectionMode event,
    Emitter<SongsState> emit,
  ) async {
    if (state is SongsLoaded) {
      final currentState = state as SongsLoaded;
      emit(
        currentState.copyWith(
          isSelectingSongs: false,
          selectedSongs: <SongsEntity>{},
        ),
      );
    }
  }

  Future<void> _onToggleSongSelection(
    ToggleSongSelection event,
    Emitter<SongsState> emit,
  ) async {
    if (state is SongsLoaded) {
      final currentState = state as SongsLoaded;
      final selected = Set<SongsEntity>.from(currentState.selectedSongs);

      if (selected.contains(event.song)) {
        selected.remove(event.song);
      } else {
        selected.add(event.song);
      }

      emit(
        currentState.copyWith(
          selectedSongs: selected,
          isSelectingSongs: selected.isNotEmpty,
        ),
      );
    }
  }
}
