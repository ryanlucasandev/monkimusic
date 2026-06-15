import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/data/datasources/audio_player_handler.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';

class ControlButtonsWidget extends StatelessWidget {
  const ControlButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is AudioPlayerReady) {
          final bool playing = state.isPlaying;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton.filledTonal(
                onPressed: () {
                  context.read<AudioPlayerBloc>().add(SkipToPreviousEvent());
                },
                icon: Icon(Icons.skip_previous_rounded),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  context.read<AudioPlayerBloc>().add(
                    PlayPausePressedEvent(isPlaying: playing),
                  );
                },
                icon: playing
                    ? const Icon(Icons.pause_rounded, size: 75)
                    : Icon(Icons.play_arrow_rounded, size: 75),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  // audioHandler.skipToNext();
                  context.read<AudioPlayerBloc>().add(SkipToNextEvent());
                },
                icon: Icon(Icons.skip_next_rounded),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
