import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/core/network/network_info.dart';
import 'package:monkimusic/core/utils/search_utils.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:uuid/uuid.dart';

part 'playlist_details_event.dart';
part 'playlist_details_state.dart';

class PlaylistDetailsBloc
    extends Bloc<PlaylistDetailsEvent, PlaylistDetailsState> {
  final PlaylistsRepository _playlistsRepository;
  final NetworkInfo _networkInfo;
  final TransferRepository _transferRepository;

  PlaylistDetailsBloc({
    required PlaylistsRepository playlistRepository,
    required NetworkInfo networkInfo,
    required TransferRepository transferRepository,
  }) : _playlistsRepository = playlistRepository,
       _networkInfo = networkInfo,
       _transferRepository = transferRepository,
       super(const PlaylistDetailsInitial()) {
    on<LoadPlaylistSongs>(_onLoadPlaylistSongs);
    on<RemoveSongFromPlaylist>(_onRemoveSongFromPlaylist);
    on<ReorderPlaylistSongs>(_onReorderPlaylistSongs);
    on<SavePlaylistOrder>(_onSavePlaylistOrder);
    on<RemoveMultipleSongsFromPlaylist>(_onRemoveMultipleSongsFromPlaylist);
    on<EnterSongSelectionMode>(_onEnterSongSelectionMode);
    on<ExitSongSelectionMode>(_onExitSongSelectionMode);
    on<ToggleSongSelection>(_onToggleSongSelection);
    on<SharePlaylist>(_onSharePlaylist);
    on<SearchChanged>(_onSearchChanged);
  }

  Future<void> _onLoadPlaylistSongs(
    LoadPlaylistSongs event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    emit(const PlaylistDetailsLoading());

    try {
      final playlistSongs = await _playlistsRepository.getPlaylistSongs(
        event.playlist.id!,
      );

      if (playlistSongs.isEmpty) {
        emit(const PlaylistDetailsEmpty());
        return;
      }

      emit(
        PlaylistDetailsLoaded(
          playlistSongs: playlistSongs,
          filteredSongs: playlistSongs,
          playlist: event.playlist,
        ),
      );
    } catch (e) {
      emit(PlaylistDetailsFailure(e.toString()));
    }
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PlaylistDetailsLoaded) return;
    final query = normalizeSearch(event.query);

    if (query.isEmpty) {
      emit(
        currentState.copyWith(
          filteredSongs: currentState.playlistSongs,
          searchQuery: '',
        ),
      );
      return;
    }

    final filteredSongs = currentState.playlistSongs.where((song) {
      final title = normalizeSearch(song.title ?? '');
      final artist = normalizeSearch(song.artist ?? '');
      final album = normalizeSearch(song.album ?? '');

      return title.contains(query) ||
          artist.contains(query) ||
          album.contains(query);
    }).toList();

    emit(
      currentState.copyWith(
        searchQuery: event.query,
        filteredSongs: filteredSongs,
      ),
    );
  }

  Future<void> _onSharePlaylist(
    SharePlaylist event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    final state = this.state;
    if (state is! PlaylistDetailsLoaded) return;
    final ip = await _networkInfo.getLocalIp();

    final connection = ShareConnectionEntity(
      ip: ip!,
      port: 8080,
      token: const Uuid().v4(),
    );

    print('QR IP: ${connection.ip}');
    print('QR PORT: ${connection.port}');
    print('QR TOKEN: ${connection.token}');

    final session = TransferSessionEntity(
      sessionId: const Uuid().v4(),
      playlist: state.playlist,
      songs: state.playlistSongs,
    );

    await _transferRepository.startServer(
      session: session,
      connection: connection,
    );

    emit(PlaylistShareReady(session, connection));
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

  Future<void> _onRemoveSongFromPlaylist(
    RemoveSongFromPlaylist event,
    Emitter<PlaylistDetailsState> emit,
  ) async {
    try {
      await _playlistsRepository.removeSongFromPlaylist(
        event.playlist.id!,
        event.songId,
      );
      add(LoadPlaylistSongs(playlist: event.playlist));
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
        event.playlist.id!,
        event.songIds,
      );
      add(LoadPlaylistSongs(playlist: event.playlist));
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
