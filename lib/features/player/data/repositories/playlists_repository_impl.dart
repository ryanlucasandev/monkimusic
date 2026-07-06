import 'package:monkimusic/features/player/data/datasources/playlists_local_datasource.dart';
import 'package:monkimusic/features/player/data/models/playlist_songs_model.dart';
import 'package:monkimusic/features/player/data/models/playlists_model.dart';
import 'package:monkimusic/features/player/domain/entities/playlist_songs_entity.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';

class PlaylistsRepositoryImpl implements PlaylistsRepository {
  final PlaylistsLocalDataSource _playlistsLocalDataSource;
  PlaylistsRepositoryImpl(this._playlistsLocalDataSource);

  @override
  Future<int> addSongToPlaylist(PlaylistSongsEntity playlistSong) {
    final model = PlaylistSongsModel.fromEntity(playlistSong);
    return _playlistsLocalDataSource.addSongToPlaylist(model);
  }

  @override
  Future<int> createPlaylist(PlaylistsEntity playlist) {
    final model = PlaylistsModel.fromEntity(playlist);
    return _playlistsLocalDataSource.createPlaylist(model);
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
  Future<int> removeSongFromPlaylist(int playlistId, int songId) {
    return _playlistsLocalDataSource.removeSongFromPlaylist(playlistId, songId);
  }

  @override
  Future<bool> updatePlaylist(PlaylistsEntity playlist) {
    final model = PlaylistsModel.fromEntity(playlist);
    return _playlistsLocalDataSource.updatePlaylist(model);
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
}
