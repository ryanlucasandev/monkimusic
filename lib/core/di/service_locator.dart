import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/core/database/daos/playlist_songs_dao.dart';
import 'package:monkimusic/core/database/daos/playlists_dao.dart';
import 'package:monkimusic/core/database/daos/songs_dao.dart';
import 'package:monkimusic/features/player/data/datasources/playlists_local_datasource.dart';
import 'package:monkimusic/features/player/data/repositories/playlists_repository_impl.dart';
import 'package:monkimusic/features/player/data/services/audio_player_handler.dart';
import 'package:monkimusic/features/player/data/repositories/audio_player_repository_impl.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/data/datasources/songs_local_datasource.dart';
import 'package:monkimusic/features/player/data/repositories/songs_repository_impl.dart';
import 'package:monkimusic/features/player/domain/repositories/songs_repository.dart';
import 'package:monkimusic/features/player/domain/usecases/fetch_device_songs_usecase.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

final locator = GetIt.instance;

Future<void> initializeLocator() async {
  locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  final audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(locator<AudioPlayer>()),
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

  // AppDb
  locator.registerLazySingleton<AppDb>(() => AppDb());

  // Playlists Dao
  locator.registerLazySingleton<PlaylistsDao>(
    () => PlaylistsDao(locator<AppDb>()),
  );

  // PlaylistSongsDao
  locator.registerLazySingleton<PlaylistSongsDao>(
    () => PlaylistSongsDao(locator<AppDb>()),
  );

  // SongsDao
  locator.registerLazySingleton<SongsDao>(() => SongsDao(locator<AppDb>()));

  // Playlist Data Sources
  locator.registerLazySingleton<PlaylistsLocalDataSource>(
    () => PlaylistsLocalDataSourceImpl(
      locator<AppDb>(),
      locator<PlaylistsDao>(),
      locator<PlaylistSongsDao>(),
      locator<SongsDao>(),
    ),
  );

  // Playlist Repositories
  locator.registerLazySingleton<PlaylistsRepository>(
    () => PlaylistsRepositoryImpl(locator<PlaylistsLocalDataSource>()),
  );
}
