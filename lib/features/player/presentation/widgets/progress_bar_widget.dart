import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:monkimusic/services/audio_background_handler.dart';

class ProgressBarWidget extends StatelessWidget {
  final AudioBackgroundHandler audioHandler;
  final MediaItem item;

  const ProgressBarWidget({
    super.key,
    required this.audioHandler,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AudioService.position,
      builder: (context, positionSnapshot) {
        if (positionSnapshot.data != null) {
          return ProgressBar(
            progress: positionSnapshot.data!,
            total: item.duration!,
            onSeek: (position) {
              audioHandler.seek(position);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
