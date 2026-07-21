// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_dao.dart';

// ignore_for_file: type=lint
mixin _$PlaylistsDaoMixin on DatabaseAccessor<AppDb> {
  $PlaylistsTableTable get playlistsTable => attachedDatabase.playlistsTable;
  $PlaylistSongsTableTable get playlistSongsTable =>
      attachedDatabase.playlistSongsTable;
  PlaylistsDaoManager get managers => PlaylistsDaoManager(this);
}

class PlaylistsDaoManager {
  final _$PlaylistsDaoMixin _db;
  PlaylistsDaoManager(this._db);
  $$PlaylistsTableTableTableManager get playlistsTable =>
      $$PlaylistsTableTableTableManager(
        _db.attachedDatabase,
        _db.playlistsTable,
      );
  $$PlaylistSongsTableTableTableManager get playlistSongsTable =>
      $$PlaylistSongsTableTableTableManager(
        _db.attachedDatabase,
        _db.playlistSongsTable,
      );
}
