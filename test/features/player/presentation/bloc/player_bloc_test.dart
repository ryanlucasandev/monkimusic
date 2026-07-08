import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';

class MockAudioPlayerRepository extends Mock implements AudioPlayerRepository {}

class FakeSongData {
  final SongsEntity? song;

  final int index;
  const FakeSongData({this.song, required this.index});
}

void main() {
  late AudioPlayerBloc audioPlayerBloc;
  late MockAudioPlayerRepository mockRepository;

  late StreamController<FakeSongData> currentSongStreamController;
  late StreamController<bool> isPlayingStreamController;

  setUpAll(() {
    registerFallbackValue(Duration.zero);
  });

  final mockSong = const SongsEntity(
    id: 1,
    title: 'Song One',
    artist: 'Artist A',
    duration: Duration(milliseconds: 100),
  );

  setUp(() {
    mockRepository = MockAudioPlayerRepository();
    currentSongStreamController = StreamController<FakeSongData>.broadcast();
    isPlayingStreamController = StreamController<bool>.broadcast();

    when(() => mockRepository.currentSongStream).thenAnswer(
      (_) => currentSongStreamController.stream.map(
        (data) => (song: data.song, index: data.index),
      ),
    );
    when(
      () => mockRepository.isPlayingStream,
    ).thenAnswer((_) => isPlayingStreamController.stream);

    audioPlayerBloc = AudioPlayerBloc(audioPlayerRepository: mockRepository);
  });

  tearDown(() {
    currentSongStreamController.close();
    isPlayingStreamController.close();
    audioPlayerBloc.close();
  });

  test('initial state should be AudioPlayerIdle', () {
    expect(audioPlayerBloc.state, equals(AudioPlayerIdle()));
  });

  test(
    'Cancels all internal repository stream subscriptions when close is invoked',
    () async {
      await audioPlayerBloc.close();

      // Verify that the stream setups are no longer listening or being acted upon
      expect(currentSongStreamController.hasListener, isFalse);
      expect(isPlayingStreamController.hasListener, isFalse);
    },
  );

  group('AudioPlayerBloc', () {
    group('LoadTrackEvent handler execution paths', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'emits AudioPlayerLoading and invokes repository configurations when loading a brand new track index while player is paused',
        build: () {
          when(() => mockRepository.loadTrack(any())).thenAnswer((_) async {});
          when(() => mockRepository.playPause(any())).thenAnswer((_) async {});
          return audioPlayerBloc;
        },
        act: (bloc) => bloc.add(LoadTrackEvent(index: 4)),
        expect: () => [const AudioPlayerLoading()],
        verify: ((_) {
          verify(() => mockRepository.loadTrack(4)).called(1);
          verify(() => mockRepository.playPause(false)).called(1);
        }),
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'emits AudioPlayerLoading but SKIPS playPause method invocation if player is already running (_isPlaying == true)',
        build: () {
          when(() => mockRepository.loadTrack(any())).thenAnswer((_) async {});
          return audioPlayerBloc;
        },
        act: (bloc) async {
          isPlayingStreamController.add(true);
          await Future.delayed(Duration.zero);
          bloc.add(const LoadTrackEvent(index: 2));
        },
        expect: () => [const AudioPlayerIdle(), const AudioPlayerLoading()],
        verify: (_) {
          verify(() => mockRepository.loadTrack(2)).called(1);
          // since _isPlaying was true, the if(!_isPlaying) bloc was bypassed
          verifyNever(() => mockRepository.playPause(any()));
        },
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'skips track load processing when requested index matches current index',
        build: () {
          when(() => mockRepository.loadTrack(any())).thenAnswer((_) async {});
          when(() => mockRepository.playPause(any())).thenAnswer((_) async {});
          return audioPlayerBloc;
        },
        act: (bloc) async {
          bloc.add(const LoadTrackEvent(index: 1));
          await Future.delayed(Duration.zero);
          bloc.add(const LoadTrackEvent(index: 1));
        },
        skip:
            1, // Ignore the state emissions resulting from Step 1 initialization
        expect: () => <AudioPlayerState>[],
        verify: (_) {
          verify(() => mockRepository.loadTrack(1)).called(1);
        },
      );
    });

    group('SeekPositionEvent handler', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'Emits nothing but calls repository seek method with the correct position duration',
        build: () {
          when(() => mockRepository.seek(any())).thenAnswer((_) async {});
          return audioPlayerBloc;
        },
        act: (bloc) =>
            bloc.add(const SeekPositionEvent(position: Duration(seconds: 10))),
        expect: () => <AudioPlayerState>[],
        verify: (_) {
          verify(
            () => mockRepository.seek(const Duration(seconds: 10)),
          ).called(1);
        },
      );
    });

    group('UpdateCurrentEvent handler', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'Emits AudioPlayerIdle when the new item is null',
        build: () => audioPlayerBloc,
        act: (bloc) =>
            bloc.add(const UpdateCurrentItemEvent(newItem: null, newIndex: -1)),
        expect: () => [AudioPlayerIdle()],
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'Emits AudioPlayerReady with correct item details when a valid item is provided',
        build: () => audioPlayerBloc,
        act: (bloc) async {
          isPlayingStreamController.add(true);
          await Future.delayed(Duration.zero);
          bloc.add(UpdateCurrentItemEvent(newItem: mockSong, newIndex: 3));
        },
        expect: () => [
          AudioPlayerIdle(),
          AudioPlayerReady(
            isPlaying: true,
            position: Duration.zero,
            currentItem: mockSong,
          ),
        ],
      );
    });

    group('SkipToNextEvent handler', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When SkipToNextEvent is fired, calls repository, updates to new item and emits AudioPlayerReady',
        build: () {
          when(() => mockRepository.skipToNext()).thenAnswer((_) async {});
          currentSongStreamController.add(
            FakeSongData(index: 1, song: mockSong),
          );
          return audioPlayerBloc;
        },
        act: (bloc) {
          bloc.add(const SkipToNextEvent());
        },
        expect: () => [
          AudioPlayerReady(
            isPlaying: false,
            position: Duration.zero,
            currentItem: mockSong,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.skipToNext()).called(1);
        },
      );
    });

    group('SkipToPreviousEvent handler', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When SkipToPreviousEvent is fired, calls repository, updates item and emits AudioPlayerReady',
        build: () {
          when(() => mockRepository.skipToPrevious()).thenAnswer((_) async {});
          currentSongStreamController.add(
            FakeSongData(index: 1, song: mockSong),
          );
          return audioPlayerBloc;
        },
        act: (bloc) {
          bloc.add(const SkipToPreviousEvent());
        },
        expect: () => [
          AudioPlayerReady(
            isPlaying: false,
            position: Duration.zero,
            currentItem: mockSong,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.skipToPrevious()).called(1);
        },
      );
    });

    group('PlayPausePressedEvent, UpdatePlaybackStateEvent handler', () {
      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When _currentSong is null, emits AudioPlayerIdle',
        build: () {
          when(() => mockRepository.playPause(true)).thenAnswer((_) async {
            isPlayingStreamController.add(true);
          });
          return audioPlayerBloc;
        },
        act: (bloc) {
          bloc.add(const PlayPausePressedEvent(playing: false));
        },
        expect: () => [AudioPlayerIdle()],
        verify: (_) {
          verify(() => mockRepository.playPause(true)).called(1);
        },
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When PlayPausePressedEvent is fired with false, invokes repository and yields AudioPlayerReady with true and preserves current song',
        build: () {
          currentSongStreamController.add(
            FakeSongData(song: mockSong, index: 1),
          );
          when(() => mockRepository.playPause(true)).thenAnswer((_) async {
            isPlayingStreamController.add(true);
          });
          return audioPlayerBloc;
        },
        seed: () => AudioPlayerReady(
          isPlaying: false,
          position: Duration.zero,
          currentItem: mockSong,
        ),
        act: (bloc) {
          bloc.add(const PlayPausePressedEvent(playing: false));
        },
        expect: () => [
          AudioPlayerReady(
            isPlaying: true,
            position: Duration.zero,
            currentItem: mockSong,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.playPause(true)).called(1);
        },
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When PlayPausePressedEvent is fired with true, invokes repository and yields AudioPlayerReady with false and preserves current song',
        build: () {
          currentSongStreamController.add(
            FakeSongData(song: mockSong, index: 1),
          );
          when(() => mockRepository.playPause(false)).thenAnswer((_) async {
            isPlayingStreamController.add(false);
          });
          return audioPlayerBloc;
        },
        seed: () => AudioPlayerReady(
          isPlaying: true,
          position: Duration.zero,
          currentItem: mockSong,
        ),
        act: (bloc) {
          bloc.add(const PlayPausePressedEvent(playing: true));
        },
        expect: () => [
          AudioPlayerReady(
            isPlaying: false,
            position: Duration.zero,
            currentItem: mockSong,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.playPause(false)).called(1);
        },
      );

      blocTest<AudioPlayerBloc, AudioPlayerState>(
        'When UpdatePlaybackStateEvent fires while state is AudioPlayerLoading, it updates internal variable but suppresses public state emission',
        build: () => audioPlayerBloc,
        seed: () => const AudioPlayerLoading(),
        act: (bloc) => bloc.add(const UpdatePlaybackStateEvent(playing: true)),
        expect: () =>
            <
              AudioPlayerState
            >[], // Asserts that the guard clause caught it and returned early!
      );
    });
  });
}
