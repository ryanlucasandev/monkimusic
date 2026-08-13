import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/transfer/transfer_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/stop_sharing_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SenderQrPage extends StatelessWidget {
  final ShareConnectionEntity connection;
  const SenderQrPage({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state is TransferCancelledState) {
          Navigator.pop(context);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          final state = context.read<TransferBloc>().state;

          if (state is TransferCompletedState) {
            Navigator.pop(context);
            return;
          }

          _confirmStopSharing(context);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Share Playlist'),
          ),
          body: Center(
            child: BlocBuilder<TransferBloc, TransferState>(
              builder: (context, state) {
                if (state is TransferInitialState) {
                  return Column(
                    mainAxisAlignment: .center,
                    children: [
                      QrImageView(
                        data: jsonEncode(
                          ShareConnectionModel(
                            ip: connection.ip,
                            port: connection.port,
                            token: connection.token,
                          ).toJson(),
                        ),
                        size: 250,
                      ),
                      ElevatedButton(
                        onPressed: () => _confirmStopSharing(context),
                        child: Text('Stop Sharing'),
                      ),
                    ],
                  );
                }

                if (state is ReceiverConnectedState) {
                  return const Text('Receiver connected');
                }

                if (state is SenderProgressState) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sending playlist',
                          style: TextStyle(fontSize: 20),
                        ),

                        const SizedBox(height: 16),
                        Text(
                          '${state.completedSongs} / ${state.session.songs.length}',
                        ),
                      ],
                    ),
                  );
                }

                if (state is TransferCompletedState) {
                  return const Text('Transfer complete');
                }

                if (state is TransferCancelledState) {
                  return const Text('Transfer cancelled');
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmStopSharing(BuildContext context) async {
    final stopSharing = await showDialog(
      context: context,
      builder: (_) => const StopSharingDialog(),
    );

    if (stopSharing == true && context.mounted) {
      context.read<TransferBloc>().add(CancelTransferEvent(connection));
    }
  }
}
