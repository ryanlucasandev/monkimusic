import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_details_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/remove_song_from_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/dialogs/select_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/pages/player_page.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class PlaylistSongWidget extends StatelessWidget {
  // MyAudioHandler for managing audio playback

  // MediaItem representing the current song
  final List<SongsEntity> songs;
  // index of the song in the list
  final int index;
  final int? currentPlaylistId;
  final bool? isReordering;

  const PlaylistSongWidget({
    super.key,
    required this.songs,
    required this.index,
    this.currentPlaylistId,
    this.isReordering,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey(songs[index].id),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        onTap: () {
          context.read<AudioPlayerBloc>().add(
            LoadTrackEvent(index: index, songs: songs),
          );

          Get.to(
            () => PlayerPage(),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 700),
          );
        },
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: const Icon(Icons.music_note),
        ),
        title: Text(
          songs[index].title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          songs[index].artist.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: isReordering!
            ? ReorderableDelayedDragStartListener(
                index: index,
                child: const Icon(Icons.drag_handle),
              )
            : PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) async {
                  switch (value) {
                    case 'add':
                      _addSongToPlaylist(context);
                      break;
                    case 'remove':
                      _removeSongFromPlaylist(context);
                      break;
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'add',
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 12),
                        Text('Add song to playlist'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'remove',
                    child: Row(
                      children: [
                        Icon(Icons.remove),
                        SizedBox(width: 12),
                        Text('Remove song from playlist'),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _addSongToPlaylist(BuildContext context) async {
    final playlistId = await showDialog<int>(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) =>
            PlaylistBloc(playlistRepository: locator<PlaylistsRepository>())
              ..add(const LoadPlaylists()),
        child: SelectPlaylistDialog(currentPlaylistId: currentPlaylistId),
      ),
    );
    if (playlistId != null && context.mounted) {
      context.read<PlaylistBloc>().add(
        AddSongToPlaylist(playlistId: playlistId, song: songs[index]),
      );
    }
  }

  void _removeSongFromPlaylist(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) =>
          RemoveSongFromPlaylistDialog(songTitle: songs[index].title!),
    );

    if (confirmed == true && context.mounted) {
      context.read<PlaylistDetailsBloc>().add(
        RemoveSongFromPlaylist(
          playlistId: currentPlaylistId!,
          songId: songs[index].id!,
        ),
      );
    }
  }
}
