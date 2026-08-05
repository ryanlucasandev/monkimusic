import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist/playlist_bloc.dart';

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({
    super.key,
    required this.title,
    required this.confirmText,
    this.initialName = '',
    required this.onSubmit,
  });
  final String title;
  final String confirmText;
  final String initialName;
  final ValueChanged<String> onSubmit;

  @override
  State<CreatePlaylistDialog> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: BlocConsumer<PlaylistBloc, PlaylistState>(
        listener: (context, state) {
          if (state is PlaylistCreated) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          String? errorText;

          if (state is PlaylistLoaded) {
            errorText = state.errorMessage;
          }

          return TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Playlist name',
              border: OutlineInputBorder(),
              errorText: errorText,
            ),
            onSubmitted: (_) => _submit(),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: Text(widget.confirmText)),
      ],
    );
  }

  void _submit() {
    final name = _controller.text.trim();

    if (name.isEmpty) return;

    widget.onSubmit(name);
  }
}
