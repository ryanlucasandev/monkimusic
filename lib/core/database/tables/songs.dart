import 'package:drift/drift.dart';

class SongsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mediaId => text().unique()();
  TextColumn get title => text()();
  TextColumn get artist => text().nullable()();
  TextColumn get album => text().nullable()();
  IntColumn get duration => integer()();
  TextColumn get filePath => text()();
  TextColumn get albumArt => text().nullable()();
}
