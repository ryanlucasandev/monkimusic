import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/songs_list/data/data_sources/fetch_device_songs_datasource.dart';
import 'package:transparent_image/transparent_image.dart';

class CoverWidget extends StatelessWidget {
  final AudioPlayerHandler audioHandler;
  final MediaItem item;
  const CoverWidget({
    super.key,
    required this.audioHandler,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.width * 0.7,
        width: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: item.artUri == null
            ? const Icon(Icons.music_note)
            : FutureBuilder(
                future: toImage(uri: item.artUri!),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: MemoryImage(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
      ),
    );
  }
}
