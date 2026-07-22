import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_details_bloc.dart';
import 'package:monkimusic/features/player/presentation/pages/songs_page.dart';
import 'package:monkimusic/features/player/presentation/widgets/playlist_song_widget.dart';

class PlaylistDetailsPage extends StatefulWidget {
  const PlaylistDetailsPage({super.key, required this.playlist});
  final PlaylistsEntity playlist;

  @override
  State<PlaylistDetailsPage> createState() => _PlaylistDetailsPageState();
}

class _PlaylistDetailsPageState extends State<PlaylistDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.name),
        actions: [
          BlocBuilder<PlaylistDetailsBloc, PlaylistDetailsState>(
            builder: (context, state) {
              if (state is! PlaylistDetailsLoaded) {
                return const SizedBox.shrink();
              }

              if (state.isReordering) {
                final playlistSongs = state.playlistSongs;

                return TextButton(
                  onPressed: () {
                    context.read<PlaylistDetailsBloc>().add(
                      SavePlaylistOrder(
                        playlistId: widget.playlist.id!,
                        songIds: playlistSongs
                            .map((song) => song.songId!)
                            .toList(),
                      ),
                    );
                  },
                  child: Text('Done'),
                );
              }

              return IconButton(
                onPressed: () {
                  context.read<PlaylistDetailsBloc>().add(
                    const ReorderPlaylistSongs(),
                  );
                },
                icon: const Icon(Icons.reorder_rounded),
                tooltip: 'Reorder songs',
              );
            },
          ),
        ],
      ),
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

            if (state.isReordering) {
              return ReorderableListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: playlistSongs.length,
                onReorderItem: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex;
                    }
                    final song = playlistSongs.removeAt(oldIndex);
                    playlistSongs.insert(newIndex, song);
                  });
                },
                itemBuilder: (context, index) {
                  final song = playlistSongs[index];
                  return PlaylistSongWidget(
                    key: ValueKey(song.id),
                    songs: playlistSongs,
                    index: index,
                    playlist: widget.playlist,
                    isReordering: true,
                  );
                },
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: playlistSongs.length,
              itemBuilder: (context, index) {
                return PlaylistSongWidget(
                  songs: playlistSongs,
                  index: index,
                  playlist: widget.playlist,
                  isReordering: false,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
