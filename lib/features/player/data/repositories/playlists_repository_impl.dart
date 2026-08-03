import 'package:monkimusic/features/player/data/datasources/playlists_local_datasource.dart';
import 'package:monkimusic/features/player/data/models/playlist_songs_model.dart';
import 'package:monkimusic/features/player/data/models/playlists_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/domain/entities/playlist_songs_entity.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';

class PlaylistsRepositoryImpl implements PlaylistsRepository {
  final PlaylistsLocalDataSource _playlistsLocalDataSource;
  PlaylistsRepositoryImpl(this._playlistsLocalDataSource);

  @override
  Future<int> createPlaylist(String name) {
    return _playlistsLocalDataSource.createPlaylist(name);
  }

  @override
  Future<int> deletePlaylist(int id) {
    return _playlistsLocalDataSource.deletePlaylist(id);
  }

  @override
  Future<List<PlaylistsEntity>> getPlaylists() async {
    final models = await _playlistsLocalDataSource.getPlaylists();
    return models.toEntityList();
  }

  @override
  Future<List<SongsEntity>> getPlaylistSongs(int playlistId) async {
    final models = await _playlistsLocalDataSource.getPlaylistSongs(playlistId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<int> addSongToPlaylist(int playlistId, SongsEntity song) {
    return _playlistsLocalDataSource.addSongToPlaylist(
      playlistId,
      SongsModel.fromEntity(song),
    );
  }

  @override
  Future<int> removeSongFromPlaylist(int playlistId, int songId) {
    return _playlistsLocalDataSource.removeSongFromPlaylist(playlistId, songId);
  }

  @override
  Future<int> renamePlaylist(int id, String name) {
    return _playlistsLocalDataSource.renamePlaylist(id, name);
  }

  @override
  Stream<List<PlaylistsEntity>> watchPlaylists() {
    final stream = _playlistsLocalDataSource.watchPlaylists();
    return stream.map((models) => models.toEntityList());
  }

  @override
  Stream<List<PlaylistSongsEntity>> watchSongsInPlaylist(int playlistId) {
    final stream = _playlistsLocalDataSource.watchSongsInPlaylist(playlistId);
    return stream.map((models) => models.toEntityList());
  }

  @override
  Future<void> reorderSongsFromPlaylist(int playlistId, List<int> songIds) =>
      _playlistsLocalDataSource.reorderSongsFromPlaylist(playlistId, songIds);

  @override
  Future<void> addMultipleSongsToPlaylist(
    int playlistId,
    Set<SongsEntity> songs,
  ) => _playlistsLocalDataSource.addMultipleSongsToPlaylist(
    playlistId,
    songs.map((song) => SongsModel.fromEntity(song)).toList(),
  );

  @override
  Future<void> removeMultipleSongsFromPlaylist(
    int playlistId,
    Set<int> songIds,
  ) => _playlistsLocalDataSource.removeMultipleSongsFromPlaylist(
    playlistId,
    songIds,
  );

  @override
  Future<void> importPlaylist(
    PlaylistsEntity playlist,
    List<SongsEntity> songs,
  ) async {
    final List<SongsModel> setSongs = songs
        .map((song) => SongsModel.fromEntity(song))
        .toList();
    await _playlistsLocalDataSource.importPlaylist(
      PlaylistsModel.fromEntity(playlist),
      setSongs,
    );
  }

  @override
  Future<PlaylistsEntity?> getPlaylistByName(String name) async {
    final playlist = await _playlistsLocalDataSource.getPlaylistByName(
      name.trim(),
    );
    return playlist?.toEntity();
  }
}
