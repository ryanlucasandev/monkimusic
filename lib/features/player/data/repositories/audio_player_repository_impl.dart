import 'package:audio_service/audio_service.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';

class AudioPlayerRepositoryImpl implements AudioPlayerRepository {
  final AudioPlayerHandler _audioHandler;
  AudioPlayerRepositoryImpl(this._audioHandler);

  @override
  Future<void> initSongs(List<SongsEntity> songs) async {
    final mediaItems = songs
        .map(
          (song) => MediaItem(
            id: song.id,
            title: song.title,
            artist: song.artist,
            duration: song.duration,
          ),
        )
        .toList();

    await _audioHandler.initSongs(mediaItems: mediaItems);
  }

  @override
  Future<void> pause() => _audioHandler.play();

  @override
  Future<void> play() => _audioHandler.pause();
}
