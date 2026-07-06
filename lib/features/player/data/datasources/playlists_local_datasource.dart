import 'package:monkimusic/core/database/daos/playlists_dao.dart';
import 'package:monkimusic/features/player/data/models/playlist_songs_model.dart';
import 'package:monkimusic/features/player/data/models/playlists_model.dart';

abstract class PlaylistsLocalDataSource {
  Future<List<PlaylistsModel>> getPlaylists();
  Future<int> createPlaylist(String name);
  Future<int> renamePlaylist(int id, String name);
  Future<int> deletePlaylist(int id);
  Future<int> addSongToPlaylist(PlaylistSongsModel playlistSongs);
  Future<int> removeSongFromPlaylist(int playlistId, int songId);
  Stream<List<PlaylistsModel>> watchPlaylists();
  Stream<List<PlaylistSongsModel>> watchSongsInPlaylist(int playlistId);
}

class PlaylistsLocalDataSourceImpl extends PlaylistsLocalDataSource {
  final PlaylistsDao _playlistsDao;
  PlaylistsLocalDataSourceImpl(this._playlistsDao);

  @override
  Future<int> addSongToPlaylist(PlaylistSongsModel playlistSongs) =>
      _playlistsDao.addSongToPlaylist(playlistSongs.toCompanion());

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
