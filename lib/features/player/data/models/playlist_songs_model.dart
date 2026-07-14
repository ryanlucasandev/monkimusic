import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/features/player/domain/entities/playlist_songs_entity.dart';

class PlaylistSongsModel {
  final int playlistId;
  final int songId;
  final int position;

  const PlaylistSongsModel({
    required this.playlistId,
    required this.songId,
    required this.position,
  });

  PlaylistSongsTableCompanion toCompanion() {
    return PlaylistSongsTableCompanion.insert(
      playlistId: playlistId,
      songId: songId,
      position: position,
    );
  }

  factory PlaylistSongsModel.fromDrift(PlaylistSongsTableData data) {
    return PlaylistSongsModel(
      playlistId: data.playlistId,
      songId: data.songId,
      position: data.position,
    );
  }

  factory PlaylistSongsModel.fromEntity(PlaylistSongsEntity entity) {
    return PlaylistSongsModel(
      playlistId: entity.playlistId,
      songId: entity.songId,
      position: entity.position,
    );
  }

  PlaylistSongsEntity toEntity() {
    return PlaylistSongsEntity(
      playlistId: playlistId,
      songId: songId,
      position: position,
    );
  }
}

extension PlaylistSongsModelX on List<PlaylistSongsModel> {
  List<PlaylistSongsEntity> toEntityList() => map((e) => e.toEntity()).toList();
}
