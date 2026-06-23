import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

abstract class AudioPlayerRepository {
  Future<void> initSongs(List<SongsEntity> songs);
  Future<void> loadTrack(int index);
  Future<void> seek(Duration position);
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> playPause(bool play);
  Stream<bool> get isPlayingStream;
  Stream<({SongsEntity? song, int index})> get currentSongStream;
}
