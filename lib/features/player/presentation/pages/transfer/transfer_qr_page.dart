import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/presentation/bloc/transfer/transfer_bloc.dart';
import 'package:monkimusic/features/player/presentation/dialogs/stop_sharing_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransferQrPage extends StatelessWidget {
  final ShareConnectionEntity connection;
  const TransferQrPage({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferBloc, TransferState>(
      listener: (context, state) {
        if (state is TransferCancelled) {
          Navigator.pop(context);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          _conformStopSharing(context);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Share Playlist'),
          ),
          body: Center(
            child: Column(
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
                  onPressed: () => _conformStopSharing(context),
                  child: Text('Stop Sharing'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _conformStopSharing(BuildContext context) async {
    final stopSharing = await showDialog(
      context: context,
      builder: (_) => const StopSharingDialog(),
    );

    if (stopSharing == true && context.mounted) {
      context.read<TransferBloc>().add(TransferCancel(connection));
    }
  }
}
