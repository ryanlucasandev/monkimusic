import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:on_audio_query_forked/on_audio_query.dart' as plugin;

class SongsModel extends SongsEntity {
  const SongsModel({
    super.songId,
    super.id,
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
      id: song.uri,
      title: song.title,
      artist: song.artist == '<unknown>' ? 'Unknown Artist' : song.artist,
      album: song.album,
      albumId: song.albumId,
      artistId: song.artistId,
      duration: song.duration != null
          ? Duration(milliseconds: song.duration!)
          : null,
      track: song.track,
      genre: song.genre,
      dateAdded: song.dateAdded,
    );
  }

  factory SongsModel.fromDrift(SongsTableData data) {
    return SongsModel(
      songId: data.songId,
      id: data.id,
      title: data.title,
      artist: data.artist,
      album: data.album,
      albumId: data.albumId,
      artistId: data.artistId,
      duration: data.duration != null
          ? Duration(milliseconds: data.duration!)
          : null,
      track: data.track,
      genre: data.genre,
      dateAdded: data.dateAdded,
    );
  }

  factory SongsModel.fromEntity(SongsEntity entity) {
    return SongsModel(
      songId: entity.songId,
      id: entity.id,
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

  SongsEntity toEntity() {
    return SongsEntity(
      songId: songId,
      id: id,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'albumId': albumId,
      'artistId': artistId,
      'duration': duration?.inMilliseconds,
      'track': track,
      'genre': genre,
      'dateAdded': dateAdded,
    };
  }

  factory SongsModel.fromJson(Map<String, dynamic> json) {
    return SongsModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      artist: json['artist'] as String?,
      album: json['album'] as String?,
      albumId: json['albumId'] as int?,
      artistId: json['artistId'] as int?,
      duration: json['duration'] != null
          ? Duration(milliseconds: json['duration'] as int)
          : null,
      track: json['track'] as int?,
      genre: json['genre'] as String?,
      dateAdded: json['dateAdded'] as int?,
    );
  }
}
