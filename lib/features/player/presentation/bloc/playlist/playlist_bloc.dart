import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monkimusic/core/utils/search_utils.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final PlaylistsRepository _playlistsRepository;

  PlaylistBloc({required PlaylistsRepository playlistRepository})
    : _playlistsRepository = playlistRepository,
      super(const PlaylistInitial()) {
    on<LoadPlaylists>(_onLoadPlaylists);
    on<CreatePlaylist>(_onCreatePlaylist);
    on<RenamePlaylist>(_onRenamePlaylist);
    on<DeletePlaylist>(_onDeletePlaylist);
    on<AddSongToPlaylist>(_onAddSongToPlaylist);
    on<AddMultipleSongsToPlaylist>(_onAddMultipleSongsToPlaylist);
    on<SearchChanged>(_onSearchChanged);
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<PlaylistState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PlaylistLoaded) return;
    final query = normalizeSearch(event.query);
    if (query.isEmpty) {
      emit(
        currentState.copyWith(
          filteredPlaylists: currentState.playlists,
          searchQuery: '',
        ),
      );
      return;
    }

    final filteredPlaylists = currentState.playlists.where((playlist) {
      final name = normalizeSearch(playlist.name);
      return name.contains(query);
    }).toList();

    print(filteredPlaylists);

    emit(
      currentState.copyWith(
        searchQuery: event.query,
        filteredPlaylists: filteredPlaylists,
      ),
    );
  }

  Future<void> _onLoadPlaylists(
    LoadPlaylists event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(const PlaylistLoading());
    try {
      final playlists = await _playlistsRepository.getPlaylists();

      if (playlists.isEmpty) {
        emit(const PlaylistEmpty());
        return;
      }

      emit(PlaylistLoaded(playlists: playlists, filteredPlaylists: playlists));
    } catch (e) {
      emit(PlaylistFailure(e.toString()));
    }
  }

  Future<void> _onCreatePlaylist(
    CreatePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      final existing = await _playlistsRepository.getPlaylistByName(event.name);
      if (existing != null) {
        final currentState = state as PlaylistLoaded;
        emit(
          PlaylistLoaded(
            playlists: currentState.playlists,
            errorMessage: 'Playlist name already exists',
          ),
        );
        return;
      }
      await _playlistsRepository.createPlaylist(event.name);
      emit(PlaylistCreated());
      add(const LoadPlaylists());
    } catch (e) {
      emit(PlaylistFailure(e.toString()));
    }
  }

  Future<void> _onRenamePlaylist(
    RenamePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      final currentState = state as PlaylistLoaded;
      final existing = await _playlistsRepository.getPlaylistByName(event.name);
      if (existing != null) {
        emit(
          PlaylistLoaded(
            playlists: currentState.playlists,
            errorMessage: 'Playlist name already exists',
          ),
        );
        return;
      }
      await _playlistsRepository.renamePlaylist(event.id, event.name);
      emit(PlaylistCreated());
      add(const LoadPlaylists());
    } catch (e) {
      emit(PlaylistFailure(e.toString()));
    }
  }

  Future<void> _onDeletePlaylist(
    DeletePlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      await _playlistsRepository.deletePlaylist(event.id);
      add(const LoadPlaylists());
    } catch (e) {
      emit(PlaylistFailure(e.toString()));
    }
  }

  Future<void> _onAddSongToPlaylist(
    AddSongToPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      await _playlistsRepository.addSongToPlaylist(
        event.playlistId,
        event.song,
      );
    } catch (_) {}
  }

  Future<void> _onAddMultipleSongsToPlaylist(
    AddMultipleSongsToPlaylist event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      await _playlistsRepository.addMultipleSongsToPlaylist(
        event.playlistId,
        event.songs,
      );
      emit(AddMultipleSongsSuccess());
      add(LoadPlaylists());
    } catch (e) {
      emit(AddMultipleSongsFailure(e.toString()));
    }
  }
}
