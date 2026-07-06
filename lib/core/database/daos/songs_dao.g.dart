// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_dao.dart';

// ignore_for_file: type=lint
mixin _$SongsDaoMixin on DatabaseAccessor<AppDb> {
  $SongsTableTable get songsTable => attachedDatabase.songsTable;
  SongsDaoManager get managers => SongsDaoManager(this);
}

class SongsDaoManager {
  final _$SongsDaoMixin _db;
  SongsDaoManager(this._db);
  $$SongsTableTableTableManager get songsTable =>
      $$SongsTableTableTableManager(_db.attachedDatabase, _db.songsTable);
}
