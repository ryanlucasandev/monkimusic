import 'package:equatable/equatable.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class TransferSessionEntity extends Equatable {
  final String sessionId;
  final PlaylistsEntity playlist;
  final List<SongsEntity> songs;

  const TransferSessionEntity({
    required this.sessionId,
    required this.playlist,
    required this.songs,
  });

  @override
  List<Object?> get props => [playlist, songs];
}
