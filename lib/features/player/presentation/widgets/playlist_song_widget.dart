import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_bloc.dart';
import 'package:monkimusic/features/player/presentation/pages/player_page.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class PlaylistSongWidget extends StatelessWidget {
  // MyAudioHandler for managing audio playback

  // MediaItem representing the current song
  final SongsEntity song;

  // index of the song in the list
  final int index;

  const PlaylistSongWidget({
    super.key,
    required this.song,
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
          context.read<AudioPlayerBloc>().add(LoadTrackEvent(index: index));

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
        title: Text(song.title!, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          song.artist.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
