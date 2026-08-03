import 'package:monkimusic/features/player/domain/entities/playlist_songs_entity.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

abstract class PlaylistsRepository {
  Future<List<PlaylistsEntity>> getPlaylists();
  Future<PlaylistsEntity?> getPlaylistByName(String name);
  Future<int> createPlaylist(String name);
  Future<int> renamePlaylist(int id, String name);
  Future<int> deletePlaylist(int id);
  Future<List<SongsEntity>> getPlaylistSongs(int playlistId);
  Future<int> addSongToPlaylist(int playlistId, SongsEntity song);
  Future<int> removeSongFromPlaylist(int playlistId, int songId);
  Future<void> reorderSongsFromPlaylist(int playlistId, List<int> songIds);
  Future<void> addMultipleSongsToPlaylist(
    int playlistId,
    Set<SongsEntity> songs,
  );
  Future<void> removeMultipleSongsFromPlaylist(
    int playlistId,
    Set<int> songsIds,
  );
  Future<void> importPlaylist(
    PlaylistsEntity playlist,
    List<SongsEntity> songs,
  );
  Stream<List<PlaylistsEntity>> watchPlaylists();
  Stream<List<PlaylistSongsEntity>> watchSongsInPlaylist(int playlistId);
}
