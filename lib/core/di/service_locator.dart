import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/player/data/repositories/audio_player_repository_impl.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/usecases/init_songs_usecase.dart';
import 'package:monkimusic/features/player/data/datasources/songs_local_datasource.dart';
import 'package:monkimusic/features/player/data/repositories/songs_repository_impl.dart';
import 'package:monkimusic/features/player/domain/repositories/songs_repository.dart';
import 'package:monkimusic/features/player/domain/usecases/fetch_device_songs_usecase.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

final locator = GetIt.instance;

Future<void> initializeLocator() async {
  final audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.monkimusic.monkimusic',
      androidNotificationChannelName: 'Audio Playback',
      androidNotificationOngoing: true,
    ),
  );
  locator.registerSingleton<AudioPlayerHandler>(audioHandler);

  locator.registerLazySingleton<OnAudioQuery>(() => OnAudioQuery());
  locator.registerLazySingleton<SongsLocalDataSource>(
    () => SongsLocalDataSourceImpl(locator<OnAudioQuery>()),
  );
  locator.registerLazySingleton<SongsRepository>(
    () => SongsRepositoryImpl(locator<SongsLocalDataSource>()),
  );

  locator.registerLazySingleton<FetchDeviceSongsUseCase>(
    () => FetchDeviceSongsUseCase(locator<SongsRepository>()),
  );

  locator.registerLazySingleton<AudioPlayerRepository>(
    () => AudioPlayerRepositoryImpl(locator<AudioPlayerHandler>()),
  );

  locator.registerLazySingleton<InitSongsUsecase>(
    () => InitSongsUsecase(locator<AudioPlayerRepository>()),
  );
}
