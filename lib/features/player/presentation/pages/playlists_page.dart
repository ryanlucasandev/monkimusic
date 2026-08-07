import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/create_playlist_dialog.dart';

import 'package:monkimusic/features/player/presentation/widgets/playlist_widget.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({super.key});

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Monki Playlists'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _controller,
                  autofocus: false,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    context.read<PlaylistBloc>().add(SearchChanged(value));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
            final playlists = state.filteredPlaylists;

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
          playlistBloc.add(LoadPlaylists());
          await showDialog<String>(
            context: context,
            builder: (_) => CreatePlaylistDialog(
              title: 'Create Playlist',
              confirmText: 'Create',
              onSubmit: (name) => {
                playlistBloc.add(CreatePlaylist(name: name)),
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
