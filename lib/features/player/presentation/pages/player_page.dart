import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:monkimusic/features/player/presentation/widgets/control_buttons_widget.dart';
import 'package:monkimusic/features/player/presentation/widgets/progress_bar_widget.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          builder: (context, state) {
            if (state is AudioPlayerLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Loading track'),
                  ],
                ),
              );
            }

            if (state is AudioPlayerError) {
              return const Center(child: Text('Failed to load song.'));
            }

            if (state is AudioPlayerReady) {
              final item = state.currentItem;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // CoverWidget(audioHandler: audioHandler, item: item),
                  Column(
                    children: [
                      Text(
                        item!.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        item.artist!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  ProgressBarWidget(item: item),
                  ControlButtonsWidget(),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
