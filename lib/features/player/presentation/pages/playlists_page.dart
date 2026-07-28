import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/create_playlist_dialog.dart';

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
        onPressed: () async {
          final playlistBloc = context.read<PlaylistBloc>();
          final name = await showDialog<String>(
            context: context,
            builder: (_) => CreatePlaylistDialog(
              title: 'Create Playlist',
              confirmText: 'Create',
            ),
          );
          if (name != null) {
            playlistBloc.add(CreatePlaylist(name: name));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
