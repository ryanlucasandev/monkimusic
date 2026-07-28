import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monkimusic/features/player/data/models/local_transfer/share_connection_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransferQrPage extends StatelessWidget {
  final TransferSessionEntity? session;
  final ShareConnectionEntity? connection;
  const TransferQrPage({super.key, this.connection, this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ip: connection!.ip,
                  port: connection!.port,
                  token: connection!.token,
                ).toJson(),
              ),
              size: 250,
            ),
          ],
        ),
      ),
    );
  }
}
