import 'package:drift/drift.dart';

class SongsTable extends Table {
  IntColumn get songId => integer().autoIncrement()();

  // content URI
  TextColumn get id => text().unique()();
  // file path for sharing playlist
  TextColumn get filePath => text().unique()();

  // Metadata
  TextColumn get title => text().nullable()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();

  IntColumn get albumId => integer().nullable()();
  IntColumn get artistId => integer().nullable()();

  // Playback info
  IntColumn get duration => integer().nullable()();

  // Album ordering
  IntColumn get track => integer().nullable()();

  // Extra metadata
  TextColumn get genre => text().nullable()();
  IntColumn get dateAdded => integer().nullable()();
}
