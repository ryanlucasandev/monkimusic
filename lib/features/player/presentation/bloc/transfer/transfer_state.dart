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
  final int currentSong;
  final int totalSongs;
  final double currentSongProgress;
  final SongsEntity song;
  final List<SongsEntity> failedSongs;

  const TransferDownloading({
    required this.currentSong,
    required this.totalSongs,
    required this.currentSongProgress,
    required this.song,
    this.failedSongs = const [],
  });

  @override
  List<Object?> get props => [currentSong, totalSongs, currentSongProgress];
}

final class TransferCompleted extends TransferState {
  const TransferCompleted();
}

final class TransferCancelled extends TransferState {
  const TransferCancelled();
}

final class TransferFailure extends TransferState {
  final String? errorMessage;
  const TransferFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
