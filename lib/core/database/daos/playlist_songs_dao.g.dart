// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_songs_dao.dart';

// ignore_for_file: type=lint
mixin _$PlaylistSongsDaoMixin on DatabaseAccessor<AppDb> {
  $PlaylistSongsTableTable get playlistSongsTable =>
      attachedDatabase.playlistSongsTable;
  $SongsTableTable get songsTable => attachedDatabase.songsTable;
  PlaylistSongsDaoManager get managers => PlaylistSongsDaoManager(this);
}

class PlaylistSongsDaoManager {
  final _$PlaylistSongsDaoMixin _db;
  PlaylistSongsDaoManager(this._db);
  $$PlaylistSongsTableTableTableManager get playlistSongsTable =>
      $$PlaylistSongsTableTableTableManager(
        _db.attachedDatabase,
        _db.playlistSongsTable,
      );
  $$SongsTableTableTableManager get songsTable =>
      $$SongsTableTableTableManager(_db.attachedDatabase, _db.songsTable);
}
