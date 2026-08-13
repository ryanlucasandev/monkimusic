part of 'transfer_bloc.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object?> get props => [];
}

final class TransferInitialState extends TransferState {
  final TransferSessionEntity? session;
  const TransferInitialState({this.session});
}

final class ReceiverConnectingState extends TransferState {
  const ReceiverConnectingState();
}

final class ReceiverConnectedState extends TransferState {
  final TransferSessionEntity session;
  const ReceiverConnectedState({required this.session});
}

final class ReceiverProgressState extends TransferState {
  final int currentSong;
  final int totalSongs;
  final double currentSongProgress;
  final SongsEntity song;
  final List<SongsEntity> failedSongs;

  const ReceiverProgressState({
    required this.currentSong,
    required this.totalSongs,
    required this.currentSongProgress,
    required this.song,
    this.failedSongs = const [],
  });

  @override
  List<Object?> get props => [
    currentSong,
    totalSongs,
    currentSongProgress,
    song,
    failedSongs,
  ];
}

final class SenderProgressState extends TransferState {
  final TransferSessionEntity session;
  final int completedSongs;
  final int? currentSongId;

  const SenderProgressState({
    required this.session,
    required this.completedSongs,
    this.currentSongId,
  });

  @override
  List<Object?> get props => [session, completedSongs, currentSongId];
}

final class TransferCompletedState extends TransferState {
  const TransferCompletedState();
}

final class TransferCancelledState extends TransferState {
  const TransferCancelledState();
}

final class TransferFailedState extends TransferState {
  final String? errorMessage;
  const TransferFailedState({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
