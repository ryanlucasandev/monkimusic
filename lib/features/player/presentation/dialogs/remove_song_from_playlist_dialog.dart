import 'package:flutter/material.dart';

class RemoveSongFromPlaylistDialog extends StatelessWidget {
  final String songTitle;

  const RemoveSongFromPlaylistDialog({super.key, required this.songTitle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text('Remove Song'),
      ),
      content: Text(
        'Are you sure you want to remove "$songTitle"?\n\n'
        'This action cannot be undone.',
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
