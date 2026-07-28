part of 'transfer_bloc.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class TransferInitial extends TransferState {
  const TransferInitial();
}

final class TransferConnecting extends TransferState {
  const TransferConnecting();
}

final class TransferConnected extends TransferState {
  final TransferSessionEntity? session;
  const TransferConnected({this.session});
}

final class TransferWaitingConfirmation extends TransferState {
  const TransferWaitingConfirmation();
}

final class TransferDownloading extends TransferState {
  final int completed;
  final int total;
  final String currentSong;

  const TransferDownloading(this.completed, this.total, this.currentSong);
}

final class TransferCompleted extends TransferState {
  const TransferCompleted();
}

final class TransferFailure extends TransferState {
  final String? errorMessage;
  const TransferFailure({this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
