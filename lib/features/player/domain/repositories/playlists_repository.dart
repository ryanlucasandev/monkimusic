import 'package:monkimusic/features/player/domain/entities/playlist_songs_entity.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';

abstract class PlaylistsRepository {
  Future<List<PlaylistsEntity>> getPlaylists();
  Future<int> createPlaylist(PlaylistsEntity playlist);
  Future<bool> updatePlaylist(PlaylistsEntity playlist);
  Future<int> deletePlaylist(int id);
  Future<int> addSongToPlaylist(PlaylistSongsEntity playlistSong);
  Future<int> removeSongFromPlaylist(int playlistId, int songId);
  Stream<List<PlaylistsEntity>> watchPlaylists();
  Stream<List<PlaylistSongsEntity>> watchSongsInPlaylist(int playlistId);
}
