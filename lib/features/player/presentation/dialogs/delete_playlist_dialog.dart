import 'package:flutter/material.dart';

class DeletePlaylistDialog extends StatelessWidget {
  final String playlistName;

  const DeletePlaylistDialog({super.key, required this.playlistName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text('Delete Playlist'),
      ),
      content: Text(
        'Are you sure you want to delete "$playlistName"?\n\n'
        'This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
