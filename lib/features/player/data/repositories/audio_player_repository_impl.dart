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

  @override
  Future<List<MediaItem>> getQueue() async {
    return await _audioHandler.getQueue();
  }

  @override
  Future<void> initSongs(List<SongsEntity> songs) async {
    await _audioHandler.initSongs(
      mediaItems: songs.map((song) => song.toMediaItem()).toList(),
    );
  }

  SongsEntity _mapMediaItemToSongEntity(MediaItem item) {
    return SongsEntity(
      uri: item.id,
      title: item.title,
      album: item.album,
      artist: item.artist,
      genre: item.genre,
      duration: item.duration,
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
        .distinct((prev, next) => prev.song?.uri == next.song?.uri);
  }
}

extension SongsEntityMapper on SongsEntity {
  MediaItem toMediaItem() {
    return MediaItem(
      id: uri!,
      title: title ?? 'No Title',
      album: album ?? 'No Album',
      artist: artist ?? 'Unknown Artist',
      genre: genre ?? 'No Genre',
      duration: duration ?? Duration.zero,
    );
  }
}
