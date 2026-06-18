import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';
import 'package:on_audio_query_forked/on_audio_query.dart' as plugin;

class SongsModel extends SongsEntity {
  const SongsModel({
    required super.id,
    required super.title,
    super.artist,
    super.duration,
  });

  factory SongsModel.fromPackage(plugin.SongModel packageSong) {
    return SongsModel(
      id: packageSong.data,
      title: packageSong.title,
      artist: packageSong.artist == '<unknown>'
          ? 'Unknown Artist'
          : packageSong.artist,
      duration: Duration(milliseconds: packageSong.duration ?? 0),
    );
  }
}
