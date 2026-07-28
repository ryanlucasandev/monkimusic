import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/usecases/fetch_device_songs_usecase.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs/songs_bloc.dart';

class MockFetchDeviceSongsUseCase extends Mock
    implements FetchDeviceSongsUseCase {}

void main() {
  late SongsBloc songsBloc;
  late MockFetchDeviceSongsUseCase mockFetchDeviceSongsUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  final tSongsList = [
    const SongsEntity(
      songId: 1,
      title: 'Song One',
      artist: 'Artist A',
      duration: Duration(milliseconds: 100),
    ),
    const SongsEntity(
      songId: 2,
      title: 'Song Two',
      artist: 'Artist B',
      duration: Duration(milliseconds: 150),
    ),
  ];

  setUp(() {
    mockFetchDeviceSongsUseCase = MockFetchDeviceSongsUseCase();

    songsBloc = SongsBloc(fetchDeviceSongs: mockFetchDeviceSongsUseCase);
  });

  tearDown(() {
    songsBloc.close();
  });

  test('initial state should be SongsInitial', () {
    expect(songsBloc.state, equals(SongsInitial()));
  });
  group('LoadSongs Event Tests', () {
    // Test Case 1: success path
    blocTest<SongsBloc, SongsState>(
      'emits [SongsLoading, SongsLoaded] when songs are fetched successfully',
      build: () {
        // stub the use cases to return successful values
        when(
          () => mockFetchDeviceSongsUseCase(any()),
        ).thenAnswer((_) async => tSongsList);
        return songsBloc;
      },
      act: (bloc) => bloc.add(LoadSongs()),
      expect: () => [SongsLoading(), SongsLoaded(allSongs: tSongsList)],
      verify: (_) {
        // verify both use cases were triggered exactly once
        verify(() => mockFetchDeviceSongsUseCase(any())).called(1);
      },
    );

    // Test case 2: Songs empty
    blocTest<SongsBloc, SongsState>(
      'emits [SongsLoading, SongsEmpty] when the returned songs list is empty',
      build: () {
        when(
          () => mockFetchDeviceSongsUseCase(any()),
        ).thenAnswer((_) async => []);
        return songsBloc;
      },
      act: (bloc) => bloc.add(LoadSongs()),
      expect: () => [SongsLoading(), SongsEmpty()],
      verify: (_) {
        verify(() => mockFetchDeviceSongsUseCase(any())).called(1);
      },
    );

    // Test Case 3: Error catch path
    blocTest<SongsBloc, SongsState>(
      'emits [SongsLoading, SongsFailure] when any error occurs while fetching songs',
      build: () {
        when(
          () => mockFetchDeviceSongsUseCase(any()),
        ).thenThrow(Exception('Storage read failure'));
        return songsBloc;
      },
      act: (bloc) => bloc.add(LoadSongs()),
      expect: () => [SongsLoading(), SongsFailure()],
      verify: (_) {
        verify(() => mockFetchDeviceSongsUseCase(any())).called(1);
      },
    );

    // Test Case 4: Audio initialization failure path
    blocTest<SongsBloc, SongsState>(
      'emits [SongsLoading, SongsFailure] when audio initialization fails',
      build: () {
        when(
          () => mockFetchDeviceSongsUseCase(any()),
        ).thenAnswer((_) async => tSongsList);
        return songsBloc;
      },
      act: (bloc) => bloc.add(LoadSongs()),
      expect: () => [SongsLoading(), SongsFailure()],
      verify: (_) {
        verify(() => mockFetchDeviceSongsUseCase(any())).called(1);
      },
    );
  });
}
