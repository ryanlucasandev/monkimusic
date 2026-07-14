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
