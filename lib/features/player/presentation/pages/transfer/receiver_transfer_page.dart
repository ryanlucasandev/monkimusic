import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/core/di/service_locator.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';

import 'package:monkimusic/features/player/domain/repositories/playlists_repository.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:monkimusic/features/player/presentation/bloc/songs/songs_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/transfer/transfer_bloc.dart';

class ReceiverTransferPage extends StatelessWidget {
  final ShareConnectionEntity connection;

  const ReceiverTransferPage({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferBloc(
        transferRepository: locator<TransferRepository>(),
        playlistRepository: locator<PlaylistsRepository>(),
      )..add(ConnectToSenderEvent(connection)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Receive Music')),
        body: BlocConsumer<TransferBloc, TransferState>(
          listenWhen: (previous, current) => current is TransferCompletedState,
          listener: (context, state) {
            if (state is TransferCompletedState) {
              context.read<SongsBloc>().add(LoadSongs());
            }
          },
          builder: (context, state) {
            if (state is ReceiverConnectingState) {
              return const Center(child: Text('Connecting...'));
            }

            if (state is TransferFailedState) {
              return Center(child: Text(state.errorMessage!));
            }

            if (state is ReceiverProgressState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Receiving songs',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 24),
                    Text(state.song.title!),
                    const SizedBox(height: 24),
                    Text(state.song.artist!),
                    const SizedBox(height: 24),

                    Text(
                      '${state.currentSong} / ${state.totalSongs}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 32),

                    // Row(
                    //   children: [

                    //     Text('${(state.currentSongProgress * 100).toInt()}%'),
                    //   ],
                    // ),
                    LinearProgressIndicator(value: state.currentSongProgress),
                  ],
                ),
              );
            }

            if (state is ReceiverConnectedState) {
              final session = state.session;

              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, size: 64),

                    const SizedBox(height: 16),
                    const Text('Connected', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 24),

                    Text(
                      session.playlist.name,
                      style: const TextStyle(fontSize: 18),
                    ),

                    Text('${session.songs.length} songs'),

                    const SizedBox(height: 32),

                    FilledButton(
                      onPressed: () {
                        context.read<TransferBloc>().add(
                          StartDownloadEvent(
                            connection: connection,
                            session: session,
                          ),
                        );
                      },
                      child: const Text('Receive'),
                    ),
                  ],
                ),
              );
            }

            if (state is TransferCompletedState) {
              return const Center(child: Text('Transfer Complete'));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
