import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';

import 'package:monkimusic/features/player/presentation/widgets/playlist_widget.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monki Playlists')),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PlaylistFailure) {
            return const Center(child: Text('Failed to load playlists.'));
          }

          if (state is PlaylistEmpty) {
            return const Center(
              child: Text('No playlist found on your device'),
            );
          }

          if (state is PlaylistLoaded) {
            final playlists = state.playlists;

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return PlaylistWidget(playlist: playlist, index: index);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PlaylistBloc>().add(
            const CreatePlaylist(name: 'My First Playlist'),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
