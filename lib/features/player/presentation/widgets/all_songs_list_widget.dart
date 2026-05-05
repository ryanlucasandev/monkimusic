import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:monkimusic/features/player/presentation/pages/player_page.dart';
import 'package:monkimusic/services/audio_background_handler.dart';

class AllSongsListWidget extends StatelessWidget {
  // MyAudioHandler for managing audio playback
  final AudioBackgroundHandler audioHandler;

  // MediaItem representing the current song
  final MediaItem item;

  // index of the song in the list
  final int index;

  const AllSongsListWidget({
    super.key,
    required this.audioHandler,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, itemSnapshot) {
        if (itemSnapshot.data != null) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: ListTile(
              onTap: () {
                if (itemSnapshot.data == item) {
                  audioHandler.skipToQueueItem(index);
                }

                Get.to(
                  () => PlayerPage(audioHandler: audioHandler),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 700),
                );
              },
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: const Icon(Icons.music_note),
              ),
              title: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                item.artist.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
