import 'package:flutter_test/flutter_test.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';

void main() {
  group('PlayerEvent Equality', () {
    group('SkipToNext, SkipToPrevious Equality', () {
      test('SkipToNext instances should be equal', () {
        expect(const SkipToNextEvent(), equals(SkipToNextEvent()));
      });
      test('SkipToPrevious instances should be equal', () {
        expect(const SkipToPreviousEvent(), equals(SkipToPreviousEvent()));
      });
    });

    group('LoadTrackEvent Equality', () {
      test('should be equal when passing the exact same index', () {
        expect(
          const LoadTrackEvent(index: 1),
          equals(const LoadTrackEvent(index: 1)),
        );
      });

      test('should NOT be equal when passing different index', () {
        expect(
          const LoadTrackEvent(index: 1),
          isNot(equals(const LoadTrackEvent(index: 2))),
        );
      });
    });

    group('SeekPositionEvent Equality', () {
      test('should be equal when the target position durations match', () {
        expect(
          const SeekPositionEvent(position: Duration(milliseconds: 100)),
          equals(
            const SeekPositionEvent(position: Duration(milliseconds: 100)),
          ),
        );
      });

      test('should NOT be equal when the target position durations differ', () {
        expect(
          const SeekPositionEvent(position: Duration(milliseconds: 100)),
          isNot(
            equals(
              const SeekPositionEvent(position: Duration(milliseconds: 150)),
            ),
          ),
        );
      });
    });

    group('UpdatePlaybackStateEvent Equality', () {
      test('should be equal when isPlaying state matches', () {
        expect(
          const UpdatePlaybackStateEvent(playing: true),
          equals(const UpdatePlaybackStateEvent(playing: true)),
        );
      });

      test('should NOT be equal when isPlaying state differs', () {
        expect(
          const UpdatePlaybackStateEvent(playing: true),
          isNot(equals(const UpdatePlaybackStateEvent(playing: false))),
        );
      });
    });

    group('PlayPausePressedEvent Equality', () {
      test('should be equal when isPlaying state matches', () {
        expect(
          const PlayPausePressedEvent(playing: true),
          equals(const PlayPausePressedEvent(playing: true)),
        );
      });

      test('should NOT be equal when isPlaying state differs', () {
        expect(
          const PlayPausePressedEvent(playing: true),
          isNot(equals(const PlayPausePressedEvent(playing: false))),
        );
      });
    });

    group('UpdateCurrentItemEvent Equality', () {
      final songA = const SongsEntity(
        id: 1,
        title: 'Song A',
        artist: 'Artist',
        duration: Duration(milliseconds: 1000),
      );

      final songB = const SongsEntity(
        id: 2,
        title: 'Song B',
        artist: 'Artist',
        duration: Duration(milliseconds: 2000),
      );

      test('should be equal when both SongsEntity and index matches', () {
        expect(
          UpdateCurrentItemEvent(newItem: songA, newIndex: 1),
          equals(UpdateCurrentItemEvent(newItem: songA, newIndex: 1)),
        );
      });

      test(
        'should NOT be equal when SongsEntity is the same and index differs',
        () {
          expect(
            UpdateCurrentItemEvent(newItem: songA, newIndex: 1),
            isNot(equals(UpdateCurrentItemEvent(newItem: songA, newIndex: 2))),
          );
        },
      );

      test(
        'should NOT be equal when SongsEntity differs and index is identical',
        () {
          expect(
            UpdateCurrentItemEvent(newItem: songA, newIndex: 1),
            isNot(equals(UpdateCurrentItemEvent(newItem: songB, newIndex: 1))),
          );
        },
      );

      test('should support value equality when both pass a null', () {
        expect(
          const UpdateCurrentItemEvent(newItem: null, newIndex: -1),

          equals(const UpdateCurrentItemEvent(newItem: null, newIndex: -1)),
        );
      });
    });
  });
}
