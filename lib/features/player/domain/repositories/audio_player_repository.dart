import 'package:audio_service/audio_service.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

abstract class AudioPlayerRepository {
  Future<List<MediaItem>> getQueue();
  Future<void> initSongs(List<SongsEntity> songs);
  Future<void> loadTrack(int index);
  Future<void> seek(Duration position);
  Future<void> skipToNext();
  Future<void> skipToPrevious();
  Future<void> playPause(bool playing);
  Future<void> setShuffleMode(bool enabled);
  Stream<bool> get isPlayingStream;
  Stream<({SongsEntity? song, int index})> get currentSongStream;
  Stream<bool> get shuffleModeEnabled;
}
