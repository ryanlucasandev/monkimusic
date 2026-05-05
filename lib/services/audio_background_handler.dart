import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioBackgroundHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  AudioPlayer audioPlayer = AudioPlayer();

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playList = queue.value;
      if (index == null || playList.isEmpty) return;
      mediaItem.add(playList[index]);
    });
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  Future<void> initSongs({required List<MediaItem> songs}) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);
    final audioSource = songs.map(_createAudioSource);

    await audioPlayer.setAudioSources(
      audioSource.toList(),
      // initialIndex: 0,
      // initialPosition: Duration.zero,
      // shuffleOrder: DefaultShuffleOrder(),
    );

    final newQueue = queue.value..addAll(songs);
    queue.add(newQueue);

    _listenForCurrentSongIndexChanges();

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }

  @override
  Future<void> play() async => audioPlayer.play();

  @override
  Future<void> pause() async => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  @override
  Future<void> skiptoQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future<void> skipToNext() async => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() async => audioPlayer.seekToPrevious();
}
