import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/songs_list/presentation/bloc/songs_list_bloc.dart';
import 'package:monkimusic/features/songs_list/presentation/widgets/songs_list_widget.dart';

class SongsListPage extends StatelessWidget {
  const SongsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monki Music')),
      body: BlocBuilder<SongsListBloc, SongsListState>(
        builder: (context, state) {
          if (state is SongsListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SongsListFailure) {
            return const Center(child: Text('Failed to load songs.'));
          }

          if (state is SongsListLoaded) {
            final songs = state.allSongs;

            if (songs.isEmpty) {
              return const Center(child: Text('No songs found on your device'));
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                MediaItem item = songs[index];
                return SongsListWidget(item: item, index: index);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
