import 'package:monkimusic/features/player/data/models/playlists_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';

class TransferSessionModel {
  final String sessionId;
  final PlaylistsModel playlist;
  final List<SongsModel> songs;

  TransferSessionModel({
    required this.sessionId,
    required this.playlist,
    required this.songs,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'playlist': playlist.toJson(),
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }

  factory TransferSessionModel.fromJson(Map<String, dynamic> json) {
    print('SESSION ID VALUE: ${json['sessionId']}');
    print('KEYS: ${json.keys}');
    return TransferSessionModel(
      sessionId: json['sessionId'] as String,
      playlist: PlaylistsModel.fromJson(
        json['playlist'] as Map<String, dynamic>,
      ),
      songs: (json['songs'] as List)
          .map((song) => SongsModel.fromJson(song))
          .toList(),
    );
  }

  factory TransferSessionModel.fromEntity(TransferSessionEntity entity) {
    return TransferSessionModel(
      sessionId: entity.sessionId,
      playlist: PlaylistsModel.fromEntity(entity.playlist),
      songs: entity.songs.map((song) => SongsModel.fromEntity(song)).toList(),
    );
  }

  TransferSessionEntity toEntity() {
    return TransferSessionEntity(
      sessionId: sessionId,
      playlist: playlist.toEntity(),
      songs: songs.map((song) => song.toEntity()).toList(),
    );
  }
}
