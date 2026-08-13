sealed class TransferServerEvent {
  const TransferServerEvent();
}

final class ReceiverConnected extends TransferServerEvent {
  const ReceiverConnected();
}

final class SongCompleted extends TransferServerEvent {
  final int songId;
  const SongCompleted(this.songId);
}

final class TransferCompleted extends TransferServerEvent {
  const TransferCompleted();
}

class TransferCancelled extends TransferServerEvent {
  const TransferCancelled();
}
