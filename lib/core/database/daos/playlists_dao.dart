import 'package:drift/drift.dart';
import 'package:monkimusic/core/database/tables/playlist_songs.dart';

import '../app_db.dart';
import '../tables/playlists.dart';

part 'playlists_dao.g.dart';

@DriftAccessor(tables: [PlaylistsTable, PlaylistSongsTable])
class PlaylistsDao extends DatabaseAccessor<AppDb> with _$PlaylistsDaoMixin {
  PlaylistsDao(super.db);

  Future<List<PlaylistsTableData>> getPlaylists() =>
      select(playlistsTable).get();

  Future<int> createPlaylist(String name) =>
      into(playlistsTable).insert(PlaylistsTableCompanion.insert(name: name));

  Future<bool> updatePlaylist(PlaylistsTableCompanion playlist) =>
      update(playlistsTable).replace(playlist);

  Future<int> deletePlaylist(int id) =>
      (delete(playlistsTable)..where((tbl) => tbl.id.equals(id))).go();

  Stream<List<PlaylistsTableData>> watchPlaylists() =>
      select(playlistsTable).watch();

  Future<int> addSongToPlaylist(PlaylistSongsTableCompanion playlistSong) =>
      into(playlistSongsTable).insert(playlistSong);

  Future<int> removeSongFromPlaylist(int playlistId, int songId) =>
      (delete(playlistSongsTable)..where(
            (tbl) =>
                tbl.playlistId.equals(playlistId) & tbl.songId.equals(songId),
          ))
          .go();

  Stream<List<PlaylistSongsTableData>> watchSongsInPlaylist(int playlistId) =>
      (select(playlistSongsTable)
            ..where((tbl) => tbl.playlistId.equals(playlistId))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]))
          .watch();
}
