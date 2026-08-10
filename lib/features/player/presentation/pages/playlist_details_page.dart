import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_details/playlist_details_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/transfer/transfer_bloc.dart';

import 'package:monkimusic/features/player/presentation/dialogs/remove_songs_from_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/pages/songs_page.dart';
import 'package:monkimusic/features/player/presentation/pages/transfer/transfer_qr_page.dart';
import 'package:monkimusic/features/player/presentation/widgets/playlist_song_widget.dart';

enum PlaylistDetailsPageMenuAction { reOrderSongs, removeSongs, share }

class PlaylistDetailsPage extends StatefulWidget {
  const PlaylistDetailsPage({super.key, required this.playlist});
  final PlaylistsEntity playlist;

  @override
  State<PlaylistDetailsPage> createState() => _PlaylistDetailsPageState();
}

class _PlaylistDetailsPageState extends State<PlaylistDetailsPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistDetailsBloc, PlaylistDetailsState>(
      listener: (context, state) {
        if (state is PlaylistShareReady) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => TransferBloc(
                  transferRepository: locator<TransferRepository>(),
                  playlistRepository: locator<PlaylistsRepository>(),
                ),
                child: TransferQrPage(connection: state.connection),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: _AppBar(playlist: widget.playlist, controller: _controller),
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => SongsPage()),
                          (route) => false,
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
              final playlistSongs = state.filteredSongs;

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
                    return KeyedSubtree(
                      key: ValueKey(song.id),
                      child: BlocProvider.value(
                        value: context.read<PlaylistDetailsBloc>(),
                        child: PlaylistSongWidget(
                          key: ValueKey(song.id),
                          songs: playlistSongs,
                          index: index,
                          playlist: widget.playlist,
                          isReordering: true,
                        ),
                      ),
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
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final PlaylistsEntity playlist;
  final TextEditingController controller;
  const _AppBar({required this.playlist, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          BlocBuilder<PlaylistDetailsBloc, PlaylistDetailsState>(
            builder: (context, state) {
              if (state is PlaylistDetailsLoaded && state.isSelectingSongs) {
                return Text('${state.selectedSongIds.length} selected');
              }
              return Text(playlist.name);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: controller,
                autofocus: false,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                onChanged: (value) {
                  context.read<PlaylistDetailsBloc>().add(SearchChanged(value));
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        BlocBuilder<PlaylistDetailsBloc, PlaylistDetailsState>(
          builder: (context, state) {
            if (state is! PlaylistDetailsLoaded) {
              return const SizedBox.shrink();
            }

            if (state.isSelectingSongs) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<PlaylistDetailsBloc>().add(
                        ExitSongSelectionMode(),
                      );
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: state.selectedSongIds.isEmpty
                        ? null
                        : () {
                            _removeSongsFromPlaylist(context);
                          },
                    child: const Text('Done'),
                  ),
                ],
              );
            }

            if (state.isReordering) {
              final playlistSongs = state.playlistSongs;

              return TextButton(
                onPressed: () {
                  context.read<PlaylistDetailsBloc>().add(
                    SavePlaylistOrder(
                      playlistId: playlist.id!,
                      songIds: playlistSongs
                          .map((song) => song.songId!)
                          .toList(),
                    ),
                  );
                },
                child: Text('Done'),
              );
            }

            return PopupMenuButton<PlaylistDetailsPageMenuAction>(
              icon: const Icon(Icons.add),
              onSelected: (value) async {
                switch (value) {
                  case PlaylistDetailsPageMenuAction.reOrderSongs:
                    context.read<PlaylistDetailsBloc>().add(
                      const ReorderPlaylistSongs(),
                    );
                    break;
                  case PlaylistDetailsPageMenuAction.removeSongs:
                    context.read<PlaylistDetailsBloc>().add(
                      EnterSongSelectionMode(),
                    );
                    break;
                  case PlaylistDetailsPageMenuAction.share:
                    context.read<PlaylistDetailsBloc>().add(SharePlaylist());
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: PlaylistDetailsPageMenuAction.reOrderSongs,
                  child: ListTile(
                    leading: Icon(Icons.reorder_rounded),
                    title: Text('Reorder songs'),
                  ),
                ),
                PopupMenuItem(
                  value: PlaylistDetailsPageMenuAction.removeSongs,
                  child: ListTile(
                    leading: Icon(Icons.remove),
                    title: Text('Remove songs'),
                  ),
                ),
                PopupMenuItem(
                  value: PlaylistDetailsPageMenuAction.share,
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share This Playlist'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _removeSongsFromPlaylist(BuildContext context) async {
    final state = context.read<PlaylistDetailsBloc>().state;
    if (state is! PlaylistDetailsLoaded) return;
    final selectedSongs = state.playlistSongs
        .where((song) => state.selectedSongIds.contains(song.songId))
        .toList();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => RemoveSongsFromPlaylistDialog(songs: selectedSongs),
    );

    if (confirmed == true && context.mounted) {
      context.read<PlaylistDetailsBloc>().add(
        RemoveMultipleSongsFromPlaylist(
          playlist: playlist,
          songIds: state.selectedSongIds,
        ),
      );
    }
  }
}
