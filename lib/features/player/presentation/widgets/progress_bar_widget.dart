import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/songs/domain/entities/songs_entity.dart';

class ProgressBarWidget extends StatelessWidget {
  final SongsEntity item;

  const ProgressBarWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is! AudioPlayerReady) {
          return const SizedBox.shrink();
        }
        return StreamBuilder<Duration>(
          stream: AudioService.position,
          builder: (context, positionSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;

            return ProgressBar(
              progress: position,
              total: item.duration ?? Duration.zero,
              onSeek: (position) {
                context.read<AudioPlayerBloc>().add(
                  SeekPositionEvent(position: position),
                );
              },
            );
          },
        );
      },
    );
  }
}
