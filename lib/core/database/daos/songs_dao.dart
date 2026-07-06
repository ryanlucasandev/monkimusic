import 'package:drift/drift.dart';

import '../app_db.dart';
import '../tables/songs.dart';

part 'songs_dao.g.dart';

@DriftAccessor(tables: [SongsTable])
class SongsDao extends DatabaseAccessor<AppDb> with _$SongsDaoMixin {
  SongsDao(super.db);

  Future<List<SongsTableData>> getSongs() => select(songsTable).get();

  Future<SongsTableData> getSong(int id) =>
      (select(songsTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<SongsTableData?> getSongByMediaId(String mediaId) => (select(
    songsTable,
  )..where((tbl) => tbl.mediaId.equals(mediaId))).getSingleOrNull();

  Stream<List<SongsTableData>> watchSongs() => select(songsTable).watch();

  Future<int> insertSong(SongsTableCompanion song) =>
      into(songsTable).insert(song);

  Future<bool> updateSong(SongsTableCompanion song) =>
      update(songsTable).replace(song);

  Future<int> deleteSong(int id) =>
      (delete(songsTable)..where((tbl) => tbl.id.equals(id))).go();
}
