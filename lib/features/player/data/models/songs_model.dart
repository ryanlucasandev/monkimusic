import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:on_audio_query_forked/on_audio_query.dart' as plugin;

class SongsModel extends SongsEntity {
  const SongsModel({
    super.id,
    super.mediaId,
    super.uri,
    super.title,
    super.artist,
    super.album,
    super.albumId,
    super.artistId,
    super.duration,
    super.track,
    super.genre,
    super.dateAdded,
  });

  factory SongsModel.fromPackage(plugin.SongModel song) {
    return SongsModel(
      id: song.id,
      mediaId: song.id,
      uri: song.uri ?? '',
      title: song.title,
      artist: song.artist == '<unknown>' ? 'Unknown Artist' : song.artist,
      album: song.album,
      albumId: song.albumId,
      artistId: song.artistId,
      duration: Duration(milliseconds: song.duration!),
      track: song.track,
      genre: song.genre,
      dateAdded: song.dateAdded,
    );
  }

  factory SongsModel.fromDrift(SongsTableData data) {
    return SongsModel(
      id: data.id,
      mediaId: data.mediaId,
      uri: data.uri,
      title: data.title,
      artist: data.artist,
      album: data.album,
      albumId: data.albumId,
      artistId: data.artistId,
      duration: Duration(milliseconds: data.duration!),
      track: data.track,
      genre: data.genre,
      dateAdded: data.dateAdded,
    );
  }

  SongsEntity toEntity() {
    return SongsEntity(
      id: id,
      mediaId: mediaId,
      uri: uri,
      title: title,
      artist: artist,
      album: album,
      albumId: albumId,
      artistId: artistId,
      duration: duration,
      track: track,
      genre: genre,
      dateAdded: dateAdded,
    );
  }

  factory SongsModel.fromEntity(SongsEntity entity) {
    return SongsModel(
      id: entity.id,
      mediaId: entity.mediaId,
      uri: entity.uri,
      title: entity.title,
      artist: entity.artist,
      album: entity.album,
      albumId: entity.albumId,
      artistId: entity.artistId,
      duration: entity.duration,
      track: entity.track,
      genre: entity.genre,
      dateAdded: entity.dateAdded,
    );
  }
}
