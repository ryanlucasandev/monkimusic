import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/playlist_bloc.dart';

class SelectPlaylistDialog extends StatelessWidget {
  const SelectPlaylistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add to playlist'),
      content: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return const CircularProgressIndicator();
          }

          if (state is PlaylistLoaded) {
            final playlists = state.playlists;

            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playlists[index];
                  return ListTile(
                    title: Text(playlist.name),
                    onTap: () {
                      Navigator.pop(context, playlist.id);
                    },
                  );
                },
              ),
            );
          }

          return const Text("No playlists found");
        },
      ),
    );
  }
}
