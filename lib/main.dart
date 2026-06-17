import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';
import 'package:monkimusic/features/songs/domain/repositories/songs_repository.dart';
import 'package:monkimusic/features/songs/presentation/bloc/songs_bloc.dart';
import 'package:monkimusic/features/songs/presentation/pages/songs_page.dart';
import 'package:monkimusic/simple_bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

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
          create: (context) => SongsBloc(
            audioHandler: locator<AudioPlayerHandler>(),
            songsRepository: locator<SongsRepository>(),
          )..add(SongsFetched()),
        ),
        BlocProvider(
          create: (context) =>
              AudioPlayerBloc(audioHandler: locator<AudioPlayerHandler>()),
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
