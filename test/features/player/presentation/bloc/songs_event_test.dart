import 'package:monkimusic/features/player/presentation/bloc/songs_bloc.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('SongsEvent Equality', () {
    test(
      'LoadSongs instances should be equal when they have the properties',
      () {
        expect(const LoadSongs(), equals(const LoadSongs()));
      },
    );
  });
}
