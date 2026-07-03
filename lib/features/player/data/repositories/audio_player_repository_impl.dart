import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:monkimusic/features/player/data/services/audio_player_handler.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:rxdart/rxdart.dart';

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
  Future<void> loadTrack(int index) => _audioHandler.skiptoQueueItem(index);

  @override
  Future<void> seek(Duration position) => _audioHandler.seek(position);

  @override
  Future<void> skipToNext() => _audioHandler.skipToNext();

  @override
  Future<void> skipToPrevious() => _audioHandler.skipToPrevious();

  @override
  Future<void> playPause(bool play) async {
    if (play) {
      _audioHandler.play();
    } else {
      _audioHandler.pause();
    }
  }

  @override
  Stream<bool> get isPlayingStream =>
      _audioHandler.playbackState.map((state) => state.playing).distinct();

  SongsEntity _mapMediaItemToSongEntity(MediaItem item) {
    return SongsEntity(
      id: item.id,
      title: item.title,
      artist: item.artist ?? 'Unknown Artist',
      duration: item.duration ?? Duration.zero,
    );
  }

  @override
  Stream<({int index, SongsEntity? song})> get currentSongStream {
    return Rx.combineLatest2<
          MediaItem?,
          int?,
          ({SongsEntity? song, int index})
        >(
          _audioHandler.mediaItem,
          _audioHandler.audioPlayer.currentIndexStream,
          (mediaItem, currentIndex) {
            if (mediaItem == null || currentIndex == null) {
              return (song: null, index: -1);
            }
            return (
              song: _mapMediaItemToSongEntity(mediaItem),
              index: currentIndex,
            );
          },
        )
        .distinct((prev, next) => prev.song?.id == next.song?.id);
  }
}
