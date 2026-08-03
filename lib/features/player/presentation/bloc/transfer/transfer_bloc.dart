import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/share_connection_entity.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/transfer_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'transfer_state.dart';
part 'transfer_event.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository _transferRepository;

  TransferBloc({required TransferRepository transferRepository})
    : _transferRepository = transferRepository,
      super(TransferInitial()) {
    on<ConnectToSender>(_onConnectToSender);
    on<StartDownload>(_onStartDownload);
  }

  Future<void> _onStartDownload(
    StartDownload event,
    Emitter<TransferState> emit,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      for (final song in event.session.songs) {
        final uri = await _transferRepository.downloadSong(
          connection: event.connection,
          song: song,
          directory: directory.path,
        );
      }

      emit(TransferCompleted());
    } catch (e) {
      TransferFailure(errorMessage: e.toString());
    }
  }

  Future<void> _onConnectToSender(
    ConnectToSender event,
    Emitter<TransferState> emit,
  ) async {
    try {
      emit(TransferConnecting());

      final session = await _transferRepository.fetchTransferSession(
        event.connection,
      );

      emit(TransferConnected(session: session));
    } catch (e) {
      emit(TransferFailure(errorMessage: e.toString()));
    }
  }
}
