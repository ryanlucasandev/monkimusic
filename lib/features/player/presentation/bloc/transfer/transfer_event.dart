part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object?> get props => [];
}

final class ConnectToSender extends TransferEvent {
  final ShareConnectionEntity connection;
  const ConnectToSender(this.connection);
}

final class StartDownload extends TransferEvent {
  final ShareConnectionEntity connection;
  final TransferSessionEntity session;

  const StartDownload({required this.connection, required this.session});
}

final class TransferCancel extends TransferEvent {
  final ShareConnectionEntity connection;
  const TransferCancel(this.connection);
}
