import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_details_bloc.dart';
import 'package:monkimusic/features/player/presentation/pages/songs_page.dart';
import 'package:monkimusic/features/player/presentation/widgets/playlist_song_widget.dart';

class PlaylistDetailsPage extends StatelessWidget {
  const PlaylistDetailsPage({super.key, required this.playlist});
  final PlaylistsEntity playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(playlist.name)),
      body: BlocBuilder<PlaylistDetailsBloc, PlaylistDetailsState>(
        builder: (context, state) {
          if (state is PlaylistDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PlaylistDetailsFailure) {
            return const Center(child: Text('Failed to load songs.'));
          }

          if (state is PlaylistDetailsEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.queue_music_outlined, size: 72),
                  const SizedBox(height: 16),
                  const Text('This playlist is empty'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SongsPage()),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add songs'),
                  ),
                ],
              ),
            );
          }

          if (state is PlaylistDetailsLoaded) {
            final playlistSongs = state.playlistSongs;

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: playlistSongs.length,
              itemBuilder: (context, index) {
                return PlaylistSongWidget(songs: playlistSongs, index: index);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
