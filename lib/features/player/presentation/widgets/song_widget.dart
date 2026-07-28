import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist/playlist_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs/songs_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/select_playlist_dialog.dart';
import 'package:monkimusic/features/player/presentation/pages/player_page.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class SongWidget extends StatelessWidget {
  // MyAudioHandler for managing audio playback

  // MediaItem representing the current song
  final List<SongsEntity> songs;

  // index of the song in the list
  final int index;

  const SongWidget({super.key, required this.songs, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongsBloc, SongsState>(
      builder: (context, state) {
        final currentState = state as SongsLoaded;
        final isSelected = currentState.selectedSongs.contains(songs[index]);
        final isSelectingSongs = currentState.isSelectingSongs;

        return Material(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ListTile(
            onTap: () {
              if (isSelectingSongs) {
                context.read<SongsBloc>().add(
                  ToggleSongSelection(songs[index]),
                );
                return;
              }

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
            trailing: isSelectingSongs
                ? Checkbox(
                    value: isSelected,
                    onChanged: (_) {
                      context.read<SongsBloc>().add(
                        ToggleSongSelection(songs[index]),
                      );
                    },
                  )
                : PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      switch (value) {
                        case 'add':
                          _addSongToPlaylist(context);
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
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _addSongToPlaylist(BuildContext context) async {
    final playlistId = await showDialog<int>(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) =>
            PlaylistBloc(playlistRepository: locator<PlaylistsRepository>())
              ..add(const LoadPlaylists()),
        child: SelectPlaylistDialog(),
      ),
    );
    if (playlistId != null && context.mounted) {
      context.read<PlaylistBloc>().add(
        AddSongToPlaylist(playlistId: playlistId, song: songs[index]),
      );
    }
  }
}
