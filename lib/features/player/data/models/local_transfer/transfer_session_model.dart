import 'package:monkimusic/features/player/data/models/playlists_model.dart';
import 'package:monkimusic/features/player/data/models/songs_model.dart';
import 'package:monkimusic/features/player/domain/entities/local_transfer/transfer_session_entity.dart';

class TransferSessionModel {
  final PlaylistsModel playlist;
  final List<SongsModel> songs;

  TransferSessionModel({required this.playlist, required this.songs});

  Map<String, dynamic> toJson() {
    return {
      'playlist': playlist.toJson(),
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }

  factory TransferSessionModel.fromJson(Map<String, dynamic> json) {
    return TransferSessionModel(
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
      playlist: PlaylistsModel.fromEntity(entity.playlist),
      songs: entity.songs.map((song) => SongsModel.fromEntity(song)).toList(),
    );
  }

  TransferSessionEntity toEntity() {
    return TransferSessionEntity(
      playlist: playlist.toEntity(),
      songs: songs.map((song) => song.toEntity()).toList(),
    );
  }
}
