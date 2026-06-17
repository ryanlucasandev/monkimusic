import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';

class MySongModel {
  final String id;
  final String title;
  final String? artist;
  final Duration? duration;
  const MySongModel({
    required this.id,
    required this.title,
    this.artist,
    this.duration,
  });
}

extension SongModelX on MySongModel {
  SongsEntity toSongEntity() {
    return SongsEntity(
      id: id,
      title: title,
      artist: artist,
      duration: duration,
    );
  }
}
