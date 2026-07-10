import 'package:drift/drift.dart';
import 'package:monkimusic/core/database/tables/playlist_songs.dart';
import 'package:monkimusic/core/database/tables/songs.dart';
import '../app_db.dart';

part 'playlist_songs_dao.g.dart';

@DriftAccessor(tables: [PlaylistSongsTable, SongsTable])
class PlaylistSongsDao extends DatabaseAccessor<AppDb>
    with _$PlaylistSongsDaoMixin {
  PlaylistSongsDao(super.db);

  Future<List<SongsTableData>> getPlaylistSongs(int playlistId) async {
    final query =
        select(songsTable).join([
            innerJoin(
              playlistSongsTable,
              playlistSongsTable.songId.equalsExp(songsTable.id),
            ),
          ])
          ..where(playlistSongsTable.playlistId.equals(playlistId))
          ..orderBy([OrderingTerm.asc(playlistSongsTable.position)]);

    final rows = await query.get();
    return rows.map((row) => row.readTable(songsTable)).toList();
  }

  Future<int> addSongToPlaylist(int playlistId, int songId) async {
    final position = await getNextPosition(playlistId);
    return into(playlistSongsTable).insert(
      PlaylistSongsTableCompanion.insert(
        playlistId: playlistId,
        songId: songId,
        position: position,
      ),
    );
  }

  Future<int> removeSongFromPlaylist({
    required int playlistId,
    required int songId,
  }) {
    final query = delete(playlistSongsTable)
      ..where((t) => t.playlistId.equals(playlistId))
      ..where((t) => t.songId.equals(songId));
    return query.go();
  }

  Future<bool> isSongInPlaylist(int playlistId, int songId) async {
    final result =
        await (select(playlistSongsTable)..where(
              (tbl) =>
                  tbl.playlistId.equals(playlistId) & tbl.songId.equals(songId),
            ))
            .getSingleOrNull();
    return result != null;
  }

  // removeSong

  Future<int> getNextPosition(int playlistId) async {
    final maxPosition = playlistSongsTable.position.max();
    final query = selectOnly(playlistSongsTable)
      ..addColumns([maxPosition])
      ..where(playlistSongsTable.playlistId.equals(playlistId));
    final row = await query.getSingle();
    final currentMax = row.read(maxPosition);
    return (currentMax ?? -1) + 1;
  }
}
