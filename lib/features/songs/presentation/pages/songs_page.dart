import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/songs/presentation/bloc/songs_bloc.dart';
import 'package:monkimusic/features/songs/presentation/widgets/songs_list_widget.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monki Music')),
      body: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          if (state is SongsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SongsFailure) {
            return const Center(child: Text('Failed to load songs.'));
          }

          if (state is SongsLoaded) {
            final songs = state.allSongs;

            if (songs.isEmpty) {
              return const Center(child: Text('No songs found on your device'));
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                MediaItem item = songs[index];
                return SongsListWidget(item: item, index: index);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
