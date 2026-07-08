import 'package:drift/drift.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';

import '../app_db.dart';
import '../tables/songs.dart';

part 'songs_dao.g.dart';

@DriftAccessor(tables: [SongsTable])
class SongsDao extends DatabaseAccessor<AppDb> with _$SongsDaoMixin {
  SongsDao(super.db);

  Future<List<SongsTableData>> getSongs() => select(songsTable).get();

  Future<SongsTableData> getSong(int id) =>
      (select(songsTable)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<SongsTableData?> getSongByMediaId(int mediaId) => (select(
    songsTable,
  )..where((tbl) => tbl.mediaId.equals(mediaId))).getSingleOrNull();

  Future<int> insertOrGetSong(SongsModel song) async {
    final existingSong = await getSongByMediaId(song.mediaId!);
    if (existingSong != null) {
      return existingSong.id;
    }
    return into(songsTable).insert(
      SongsTableCompanion.insert(
        mediaId: song.mediaId!,
        uri: Value(song.uri!),
        title: Value(song.title!),
        artist: Value(song.artist),
        duration: Value(song.duration!.inMilliseconds),
      ),
    );
  }

  Stream<List<SongsTableData>> watchSongs() => select(songsTable).watch();

  Future<int> insertSong(SongsTableCompanion song) =>
      into(songsTable).insert(song);

  Future<bool> updateSong(SongsTableCompanion song) =>
      update(songsTable).replace(song);

  Future<int> deleteSong(int id) =>
      (delete(songsTable)..where((tbl) => tbl.id.equals(id))).go();
}
