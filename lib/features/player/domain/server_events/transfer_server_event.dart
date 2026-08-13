sealed class SenderServerEvent {
  const SenderServerEvent();
}

final class ReceiverConnected extends SenderServerEvent {
  const ReceiverConnected();
}

final class SongCompleted extends SenderServerEvent {
  final int songId;
  const SongCompleted(this.songId);
}

final class TransferCompleted extends SenderServerEvent {
  const TransferCompleted();
}

final class TransferCancelled extends SenderServerEvent {
  const TransferCancelled();
}

final class ReceiverDisconnected extends SenderServerEvent {
  const ReceiverDisconnected();
}
