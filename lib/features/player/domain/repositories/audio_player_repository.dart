import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';

abstract class AudioPlayerRepository {
  Future<void> initSongs(List<SongsEntity> songs);
  Future<void> play();
  Future<void> pause();
}
