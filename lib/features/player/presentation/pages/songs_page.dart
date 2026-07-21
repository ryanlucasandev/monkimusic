import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/select_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/pages/playlists_page.dart';
import 'package:monkimusic/features/player/presentation/widgets/song_widget.dart';

enum SongsPageMenuAction { playlists, addSongs }

class SongsPage extends StatelessWidget {
  const SongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is AddMultipleSongsSuccess) {
          context.read<SongsBloc>().add(ExitSongSelectionMode());
          _showMaterialBanner(context, 'Songs added to playlist');
        }

        if (state is AddMultipleSongsFailure) {
          _showMaterialBanner(context, 'Failed to add songs to playlist');
        }
      },
      child: Scaffold(
        appBar: const _SongsPageAppBar(),
        body: BlocBuilder<SongsBloc, SongsState>(
          builder: (context, state) {
            if (state is SongsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SongsFailure) {
              return const Center(child: Text('Failed to load songs.'));
            }

            if (state is SongsEmpty) {
              return const Center(child: Text('No songs found on your device'));
            }

            if (state is SongsLoaded) {
              final songs = state.allSongs;

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return SongWidget(songs: songs, index: index);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showMaterialBanner(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}

class _SongsPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SongsPageAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<SongsBloc, SongsState>(
        builder: (context, state) {
          if (state is SongsLoaded && state.isSelectingSongs) {
            return Text('${state.selectedSongs.length} selected');
          }
          return const Text('Monki Music');
        },
      ),
      actions: [
        BlocBuilder<SongsBloc, SongsState>(
          builder: (context, state) {
            if (state is! SongsLoaded) {
              return const SizedBox.shrink();
            }

            if (state.isSelectingSongs) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<SongsBloc>().add(ExitSongSelectionMode());
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: state.selectedSongs.isEmpty
                        ? null
                        : () {
                            _selectPlaylist(context);
                          },
                    child: const Text('Select Playlist'),
                  ),
                ],
              );
            }

            return PopupMenuButton<SongsPageMenuAction>(
              icon: const Icon(Icons.add),
              onSelected: (value) async {
                switch (value) {
                  case SongsPageMenuAction.playlists:
                    context.read<PlaylistBloc>().add(LoadPlaylists());
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PlaylistsPage()),
                    );
                    break;
                  case SongsPageMenuAction.addSongs:
                    context.read<SongsBloc>().add(EnterSongSelectionMode());
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: SongsPageMenuAction.playlists,
                  child: ListTile(
                    leading: Icon(Icons.queue_music),
                    title: Text('Playlists'),
                  ),
                ),
                PopupMenuItem(
                  value: SongsPageMenuAction.addSongs,
                  child: ListTile(
                    leading: Icon(Icons.playlist_add),
                    title: Text('Add songs to playlist'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _selectPlaylist(BuildContext context) async {
    final songsBlocState = context.read<SongsBloc>().state;
    if (songsBlocState is! SongsLoaded) return;
    final selectedSongs = songsBlocState.selectedSongs.toSet();

    context.read<PlaylistBloc>().add(const LoadPlaylists());
    final playlistId = await showDialog<int>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<PlaylistBloc>(),
        child: SelectPlaylistDialog(),
      ),
    );
    if (playlistId != null && context.mounted) {
      context.read<PlaylistBloc>().add(
        AddMultipleSongsToPlaylist(
          playlistId: playlistId,
          songs: selectedSongs,
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
