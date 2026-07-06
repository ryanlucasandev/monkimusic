import 'package:drift/drift.dart';

class PlaylistSongsTable extends Table {
  IntColumn get playlistId => integer()();
  IntColumn get songId => integer()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, songId};
}
