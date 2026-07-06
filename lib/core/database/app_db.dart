import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:monkimusic/core/database/daos/playlists_dao.dart';
import 'package:monkimusic/core/database/daos/songs_dao.dart';
import 'package:monkimusic/core/database/tables/playlist_songs.dart';
import 'package:monkimusic/core/database/tables/playlists.dart';
import 'package:monkimusic/core/database/tables/songs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'playlists.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [SongsTable, PlaylistsTable, PlaylistSongsTable],
  daos: [SongsDao, PlaylistsDao],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //
}
