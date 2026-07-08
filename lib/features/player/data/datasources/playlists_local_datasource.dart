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
  Stream<List<PlaylistsModel>> watchPlaylists();
  Stream<List<PlaylistSongsModel>> watchSongsInPlaylist(int playlistId);
}

class PlaylistsLocalDataSourceImpl extends PlaylistsLocalDataSource {
  final PlaylistsDao _playlistsDao;
  final PlaylistSongsDao _playlistSongsDao;
  final SongsDao _songsDao;
  PlaylistsLocalDataSourceImpl(
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
  Future<int> removeSongFromPlaylist(int playlistId, int songId) =>
      _playlistsDao.removeSongFromPlaylist(playlistId, songId);

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
}
