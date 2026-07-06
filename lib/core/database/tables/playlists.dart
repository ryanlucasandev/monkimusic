import 'package:drift/drift.dart';

class PlaylistsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get coverArtPath => text().named('cover_art_path').nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
