import 'package:flutter_test/flutter_test.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/player/player_bloc.dart';

void main() {
  group('AudioPlayerState Equality', () {
    group('AudioPlayerIdle, AudioPlayerLoading', () {
      test('should support value equality for parameterless states', () {
        expect(const AudioPlayerIdle(), equals(const AudioPlayerIdle()));
        expect(const AudioPlayerLoading(), equals(const AudioPlayerLoading()));
      });
    });

    group('AudioPlayerError', () {
      test('should be equal when error message matches', () {
        expect(
          const AudioPlayerError('Audio Player Error'),
          equals(const AudioPlayerError('Audio Player Error')),
        );
      });
      test('should NOT be equal when error messages differ', () {
        expect(
          const AudioPlayerError('Audio Player Error'),
          isNot(
            equals(
              const AudioPlayerError('Audio Player Initialization Failed'),
            ),
          ),
        );
      });
    });

    group('AudioPlayerReady', () {
      final songA = const SongsEntity(
        songId: 1,
        title: 'Song A',
        artist: 'Artist',
        duration: Duration(milliseconds: 1000),
      );

      final songB = const SongsEntity(
        songId: 2,
        title: 'Song B',
        artist: 'Artist',
        duration: Duration(milliseconds: 1500),
      );
      test('should be equal when all properties matches', () {
        expect(
          AudioPlayerReady(
            isPlaying: true,
            position: const Duration(milliseconds: 1000),
            currentItem: songA,
          ),
          equals(
            AudioPlayerReady(
              isPlaying: true,
              position: const Duration(milliseconds: 1000),
              currentItem: songA,
            ),
          ),
        );
      });

      test('should NOT be equal when properties differ', () {
        // Track changes
        expect(
          AudioPlayerReady(
            isPlaying: true,
            position: const Duration(milliseconds: 1000),
            currentItem: songA,
          ),
          isNot(
            equals(
              AudioPlayerReady(
                isPlaying: true,
                position: const Duration(milliseconds: 1000),
                currentItem: songB,
              ),
            ),
          ),
        );

        // Play/Pause state changes
        expect(
          AudioPlayerReady(
            isPlaying: true,
            position: const Duration(milliseconds: 1000),
            currentItem: songA,
          ),
          isNot(
            equals(
              AudioPlayerReady(
                isPlaying: false,
                position: const Duration(milliseconds: 1000),
                currentItem: songA,
              ),
            ),
          ),
        );
        // Playback tracking position changes
        expect(
          AudioPlayerReady(
            isPlaying: true,
            position: const Duration(milliseconds: 1000),
            currentItem: songA,
          ),
          isNot(
            equals(
              AudioPlayerReady(
                isPlaying: true,
                position: const Duration(milliseconds: 1500),
                currentItem: songA,
              ),
            ),
          ),
        );
      });

      test('should be equal when thown null currentItem', () {
        expect(
          AudioPlayerReady(
            isPlaying: false,
            position: Duration.zero,
            currentItem: null,
          ),
          equals(
            AudioPlayerReady(
              isPlaying: false,
              position: Duration.zero,
              currentItem: null,
            ),
          ),
        );
      });

      group('copyWith', () {
        test(
          'should return identical instance configuration when no parameters are provided',
          () {
            final baseState = AudioPlayerReady(
              isPlaying: true,
              position: const Duration(seconds: 10),
              currentItem: songA,
            );
            final updatedState = baseState.copyWith();

            expect(updatedState, equals(baseState));
          },
        );

        test(
          'should modify only specified attributes while keeping unchanged fields intact',
          () {
            final baseState = AudioPlayerReady(
              isPlaying: true,
              position: const Duration(seconds: 10),
              currentItem: songA,
            );
            final updatedState = baseState.copyWith(
              isPlaying: false,
              position: const Duration(milliseconds: 1000),
            );

            expect(updatedState.currentItem, equals(songA));
            expect(updatedState.isPlaying, false);
            expect(
              updatedState.position,
              equals(const Duration(milliseconds: 1000)),
            );
          },
        );
      });
    });
  });
}
