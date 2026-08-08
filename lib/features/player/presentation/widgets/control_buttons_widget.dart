import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/player/player_bloc.dart';

class ControlButtonsWidget extends StatelessWidget {
  const ControlButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        if (state is AudioPlayerReady) {
          final bool playing = state.isPlaying;
          final bool shuffleEnabled = state.isShuffleEnabled;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton.filledTonal(
                onPressed: () {
                  context.read<AudioPlayerBloc>().add(ToggleShuffle());
                },
                icon: shuffleEnabled
                    ? const Icon(Icons.shuffle_on_sharp)
                    : const Icon(Icons.shuffle),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  context.read<AudioPlayerBloc>().add(SkipToPreviousEvent());
                },
                icon: Icon(Icons.skip_previous_rounded),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  context.read<AudioPlayerBloc>().add(
                    PlayPausePressedEvent(playing: playing),
                  );
                },
                icon: playing
                    ? const Icon(Icons.pause_rounded, size: 75)
                    : const Icon(Icons.play_arrow_rounded, size: 75),
              ),
              IconButton.filledTonal(
                onPressed: () {
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
