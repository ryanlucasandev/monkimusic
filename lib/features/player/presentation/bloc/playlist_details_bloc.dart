import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';

part 'playlist_details_event.dart';
part 'playlist_details_state.dart';

class PlaylistDetailsBloc
    extends Bloc<PlaylistDetailsEvent, PlaylistDetailsState> {
  final PlaylistsRepository _playlistsRepository;

  PlaylistDetailsBloc({required PlaylistsRepository playlistRepository})
    : _playlistsRepository = playlistRepository,
      super(const PlaylistDetailsInitial()) {
    on<LoadPlaylistSongs>(_onLoadPlaylistSongs);
    on<RemoveSongFromPlaylist>(_onRemoveSongFromPlaylist);
    on<ReorderPlaylistSongs>(_onReorderPlaylistSongs);
    on<SavePlaylistOrder>(_onSavePlaylistOrder);
    on<RemoveMultipleSongsFromPlaylist>(_onRemoveMultipleSongsFromPlaylist);
    on<EnterSongSelectionMode>(_onEnterSongSelectionMode);
    on<ExitSongSelectionMode>(_onExitSongSelectionMode);
    on<ToggleSongSelection>(_onToggleSongSelection);
  }

  Future<void> _onToggleSongSelection(
    ToggleSongSelection event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    if (state is PlaylistDetailsLoaded) {
      final currentState = state as PlaylistDetailsLoaded;
      final selected = Set<int>.from(currentState.selectedSongIds);

      if (selected.contains(event.songId)) {
        selected.remove(event.songId);
      } else {
        selected.add(event.songId);
      }

      emit(
        currentState.copyWith(
          selectedSongIds: selected,
          isSelectingSongs: selected.isNotEmpty,
        ),
      );
    }
  }

  Future<void> _onEnterSongSelectionMode(
    EnterSongSelectionMode event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    if (state is PlaylistDetailsLoaded) {
      final currentState = state as PlaylistDetailsLoaded;
      emit(currentState.copyWith(isSelectingSongs: true));
    }
  }

  Future<void> _onExitSongSelectionMode(
    ExitSongSelectionMode event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    if (state is PlaylistDetailsLoaded) {
      final currentState = state as PlaylistDetailsLoaded;
      emit(
        currentState.copyWith(
          isSelectingSongs: false,
          selectedSongIds: <int>{},
        ),
      );
    }
  }

  Future<void> _onSavePlaylistOrder(
    SavePlaylistOrder event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PlaylistDetailsLoaded) return;
    try {
      await _playlistsRepository.reorderSongsFromPlaylist(
        event.playlistId,
        event.songIds,
      );

      emit(currentState.copyWith(isReordering: false));
    } catch (e) {
      emit(PlaylistDetailsFailure(e.toString()));
    }
  }

  Future<void> _onLoadPlaylistSongs(
    LoadPlaylistSongs event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    emit(const PlaylistDetailsLoading());

    try {
      final playlistSongs = await _playlistsRepository.getPlaylistSongs(
        event.playlistId,
      );

      if (playlistSongs.isEmpty) {
        emit(const PlaylistDetailsEmpty());
        return;
      }

      emit(PlaylistDetailsLoaded(playlistSongs: playlistSongs));
    } catch (e) {
      emit(PlaylistDetailsFailure(e.toString()));
    }
  }

  Future<void> _onRemoveSongFromPlaylist(
    RemoveSongFromPlaylist event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    try {
      await _playlistsRepository.removeSongFromPlaylist(
        event.playlistId,
        event.songId,
      );
      add(LoadPlaylistSongs(playlistId: event.playlistId));
    } catch (e) {
      emit(PlaylistDetailsFailure(e.toString()));
    }
  }

  Future<void> _onRemoveMultipleSongsFromPlaylist(
    RemoveMultipleSongsFromPlaylist event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    try {
      await _playlistsRepository.removeMultipleSongsFromPlaylist(
        event.playlistId,
        event.songIds,
      );
      add(LoadPlaylistSongs(playlistId: event.playlistId));
    } catch (e) {
      emit(PlaylistDetailsFailure(e.toString()));
    }
  }

  Future<void> _onReorderPlaylistSongs(
    ReorderPlaylistSongs event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    final state = this.state;
    if (state is PlaylistDetailsLoaded) {
      emit(state.copyWith(isReordering: true));
    }
  }
}
