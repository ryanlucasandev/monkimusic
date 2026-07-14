import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('SongsState Equality', () {
    test(
      'SongsInitial, SongsLoading, and SongsEmpty supports value equality',
      () {
        expect(const SongsInitial(), equals(const SongsInitial()));
        expect(const SongsLoading(), equals(const SongsLoading()));
        expect(const SongsEmpty(), equals(SongsEmpty()));
      },
    );

    // test SongsLoaded State with Data
    group('SongsLoaded', () {
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

      test('should be equal when the lists contain identical songs', () {
        expect(
          SongsLoaded(allSongs: [songA, songB]),
          equals(SongsLoaded(allSongs: [songA, songB])),
        );
      });

      test('should NOT be qual when the lists contain different songs', () {
        expect(
          SongsLoaded(allSongs: [songA]),
          isNot(equals(SongsLoaded(allSongs: [songB]))),
        );
      });

      test('should NOT be equal when the order of songs is different', () {
        expect(
          SongsLoaded(allSongs: [songA, songB]),
          isNot(equals(SongsLoaded(allSongs: [songB, songA]))),
        );
      });
    });

    group('SongsFailure', () {
      test('should be equal when the error messages are identical', () {
        expect(
          const SongsFailure(errorMessage: 'Storage Permission Denied'),
          equals(const SongsFailure(errorMessage: 'Storage Permission Denied')),
        );
      });

      test('should NOT be equal when the error messages differ', () {
        expect(
          const SongsFailure(errorMessage: 'Storage Error'),
          isNot(equals(const SongsFailure(errorMessage: 'Audio Engine Error'))),
        );
      });

      test('should be equal when both error messages are null', () {
        expect(const SongsFailure(), equals(SongsFailure()));
      });
    });
  });
}
