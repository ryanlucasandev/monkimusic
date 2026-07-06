import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/delete_playlist_dialog.dart';

class PlaylistWidget extends StatelessWidget {
  // MyAudioHandler for managing audio playback

  // MediaItem representing the current song
  final PlaylistsEntity playlist;

  // index of the song in the list
  final int index;

  const PlaylistWidget({
    super.key,
    required this.playlist,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: ListTile(
        onTap: () {},
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
          playlist.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          playlist.createdAt.toIso8601String(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) async {
            final playlistBloc = context.read<PlaylistBloc>();
            switch (value) {
              case 'rename':
                playlistBloc.add(
                  RenamePlaylist(name: 'Rename Playlist', id: playlist.id!),
                );
                break;
              case 'delete':
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) =>
                      DeletePlaylistDialog(playlistName: playlist.name),
                );

                if (confirmed == true) {
                  playlistBloc.add(DeletePlaylist(id: playlist.id!));
                }
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'rename',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 12),
                  Text('Rename'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 12),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
