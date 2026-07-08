import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_details_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/create_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/dialogs/delete_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/pages/playlist_details_page.dart';

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => PlaylistDetailsBloc(
                  playlistRepository: locator<PlaylistsRepository>(),
                )..add(LoadPlaylistSongs(playlistId: playlist.id!)),
                child: PlaylistDetailsPage(playlist: playlist),
              ),
            ),
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
                final name = await showDialog<String>(
                  context: context,
                  builder: (_) => CreatePlaylistDialog(
                    title: 'Rename Playlist',
                    confirmText: 'Save',
                    initialName: playlist.name,
                  ),
                );
                if (name != null) {
                  playlistBloc.add(
                    RenamePlaylist(name: name, id: playlist.id!),
                  );
                }
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
