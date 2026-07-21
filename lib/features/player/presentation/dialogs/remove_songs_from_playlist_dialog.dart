import 'package:flutter/material.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class RemoveSongsFromPlaylistDialog extends StatelessWidget {
  final List<SongsEntity> songs;

  const RemoveSongsFromPlaylistDialog({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text('Remove Songs?'),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(song.title ?? 'Unknown Title'),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Remove'),
        ),
      ],
    );
  }
}
