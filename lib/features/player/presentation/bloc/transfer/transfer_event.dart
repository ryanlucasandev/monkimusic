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
