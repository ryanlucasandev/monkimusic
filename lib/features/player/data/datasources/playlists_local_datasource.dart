import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/core/database/daos/playlist_songs_dao.dart';
import 'package:monkimusic/core/database/daos/playlists_dao.dart';
import 'package:monkimusic/core/database/daos/songs_dao.dart';
import 'package:monkimusic/features/player/data/models/playlist_songs_model.dart';
import 'package:monkimusic/features/player/data/models/playlists_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';

abstract class PlaylistsLocalDataSource {
  Future<List<PlaylistsModel>> getPlaylists();
  Future<int> createPlaylist(String name);
  Future<int> renamePlaylist(int id, String name);
  Future<int> deletePlaylist(int id);
  Future<List<SongsModel>> getPlaylistSongs(int playlistId);
  Future<int> addSongToPlaylist(int playlistId, SongsModel song);
  Future<int> removeSongFromPlaylist(int playlistId, int songId);
  Future<void> reorderSongsFromPlaylist(int playlistId, List<int> songIds);
  Stream<List<PlaylistsModel>> watchPlaylists();
  Stream<List<PlaylistSongsModel>> watchSongsInPlaylist(int playlistId);
  Future<void> addMultipleSongsToPlaylist(
    int playlistId,
    List<SongsModel> songs,
  );
}

class PlaylistsLocalDataSourceImpl extends PlaylistsLocalDataSource {
  final AppDb _appDb;
  final PlaylistsDao _playlistsDao;
  final PlaylistSongsDao _playlistSongsDao;
  final SongsDao _songsDao;
  PlaylistsLocalDataSourceImpl(
    this._appDb,
    this._playlistsDao,
    this._playlistSongsDao,
    this._songsDao,
  );

  @override
  Future<int> createPlaylist(String name) => _playlistsDao.createPlaylist(name);

  @override
  Future<int> deletePlaylist(int id) => _playlistsDao.deletePlaylist(id);

  @override
  Future<List<PlaylistsModel>> getPlaylists() async {
    final playlists = await _playlistsDao.getPlaylists();
    return playlists.map(PlaylistsModel.fromDrift).toList();
  }

  @override
  Future<List<SongsModel>> getPlaylistSongs(int playlistId) async {
    final playlistSongs = await _playlistSongsDao.getPlaylistSongs(playlistId);
    return playlistSongs.map(SongsModel.fromDrift).toList();
  }

  @override
  Future<int> addSongToPlaylist(int playlistId, SongsModel song) async {
    final songId = await _songsDao.insertOrGetSong(song);
    final added = await _playlistSongsDao.addSongToPlaylist(playlistId, songId);
    return added;
  }

  @override
  Future<int> removeSongFromPlaylist(int playlistId, int songId) {
    final deleted = _playlistSongsDao.removeSongFromPlaylist(
      playlistId: playlistId,
      songId: songId,
    );
    return deleted;
  }

  @override
  Future<int> renamePlaylist(int id, String name) =>
      _playlistsDao.renamePlaylist(id, name);

  @override
  Stream<List<PlaylistsModel>> watchPlaylists() => _playlistsDao
      .watchPlaylists()
      .map((playlists) => playlists.map(PlaylistsModel.fromDrift).toList());

  @override
  Stream<List<PlaylistSongsModel>> watchSongsInPlaylist(int playlistId) =>
      _playlistsDao
          .watchSongsInPlaylist(playlistId)
          .map(
            (playlistSongs) =>
                playlistSongs.map(PlaylistSongsModel.fromDrift).toList(),
          );

  @override
  Future<void> reorderSongsFromPlaylist(int playlistId, List<int> songIds) =>
      _playlistSongsDao.reorderSongsFromPlaylist(
        playlistId: playlistId,
        songIds: songIds,
      );

  @override
  Future<void> addMultipleSongsToPlaylist(
    int playlistId,
    List<SongsModel> songs,
  ) async {
    await _appDb.transaction(() async {
      var position = await _playlistSongsDao.getNextPosition(playlistId);

      for (final song in songs) {
        final songId = await _songsDao.insertOrGetSong(song);

        final exists = await _playlistSongsDao.isSongInPlaylist(
          playlistId,
          songId,
        );
        if (!exists) {
          await _playlistSongsDao.insertSongToPlaylist(
            playlistId,
            songId,
            position++,
          );
        }
      }
    });
  }
}
