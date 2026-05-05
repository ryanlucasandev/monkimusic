import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:monkimusic/features/player/presentation/widgets/all_songs_list_widget.dart';
import 'package:monkimusic/services/audio_background_handler.dart';
import 'package:monkimusic/services/fetch_songs.dart';
import 'package:monkimusic/services/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MediaItem> allSongs = [];
  final audioHandler = locator<AudioBackgroundHandler>();

  @override
  void initState() {
    FetchSongs.execute().then((value) {
      setState(() {
        allSongs = value;
      });
      audioHandler.initSongs(songs: value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monki Music')),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allSongs.length,
        itemBuilder: (context, index) {
          MediaItem item = allSongs[index];
          return AllSongsListWidget(
            audioHandler: audioHandler,
            item: item,
            index: index,
          );
        },
      ),
    );
  }
}
