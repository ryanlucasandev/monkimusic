part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object?> get props => [];
}

final class ConnectToSenderEvent extends TransferEvent {
  final ShareConnectionEntity connection;
  const ConnectToSenderEvent(this.connection);
}

final class StartDownloadEvent extends TransferEvent {
  final ShareConnectionEntity connection;
  final TransferSessionEntity session;

  const StartDownloadEvent({required this.connection, required this.session});
}

final class CancelTransferEvent extends TransferEvent {
  final ShareConnectionEntity connection;
  const CancelTransferEvent(this.connection);
}

final class ReceiverConnectedEvent extends TransferEvent {
  const ReceiverConnectedEvent();
}

final class SongCompletedEvent extends TransferEvent {
  final int songId;
  const SongCompletedEvent(this.songId);
}

final class TransferCompletedEvent extends TransferEvent {
  const TransferCompletedEvent();
}

final class TransferCancelledEvent extends TransferEvent {
  const TransferCancelledEvent();
}
