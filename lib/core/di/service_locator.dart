import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:monkimusic/services/audio_player_handler.dart';

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
}
