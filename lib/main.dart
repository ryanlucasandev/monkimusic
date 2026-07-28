import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:monkimusic/features/player/domain/usecases/fetch_device_songs_usecase.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs/songs_bloc.dart';
import 'package:monkimusic/features/player/presentation/pages/songs_page.dart';
import 'package:monkimusic/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  await initializeLocator();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SongsBloc(fetchDeviceSongs: locator<FetchDeviceSongsUseCase>())
                ..add(LoadSongs()),
        ),
        BlocProvider(
          create: (context) => AudioPlayerBloc(
            audioPlayerRepository: locator<AudioPlayerRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              PlaylistBloc(playlistRepository: locator<PlaylistsRepository>())
                ..add(LoadPlaylists()),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        debugShowCheckedModeBanner: false,
        home: SongsPage(),
      ),
    );
  }
}
