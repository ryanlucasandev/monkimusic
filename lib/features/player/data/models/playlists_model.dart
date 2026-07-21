import 'package:drift/drift.dart';
import 'package:monkimusic/core/database/app_db.dart';
import 'package:monkimusic/features/player/domain/entities/playlists_entity.dart';

class PlaylistsModel {
  final int? id;
  final String name;
  final String? coverArtPath;
  final DateTime createdAt;

  const PlaylistsModel({
    this.id,
    required this.name,
    this.coverArtPath,
    required this.createdAt,
  });

  PlaylistsTableCompanion toInsertCompanion() {
    return PlaylistsTableCompanion.insert(
      name: name,
      coverArtPath: Value(coverArtPath),
      createdAt: Value(createdAt),
    );
  }

  PlaylistsTableCompanion toUpdateCompanion() {
    if (id == null) {
      throw StateError('Cannot update a playlist without an id.');
    }

    return PlaylistsTableCompanion(
      id: Value(id!),
      name: Value(name),
      coverArtPath: Value(coverArtPath),
      createdAt: Value(createdAt),
    );
  }

  factory PlaylistsModel.fromDrift(PlaylistsTableData data) {
    return PlaylistsModel(
      id: data.id,
      name: data.name,
      coverArtPath: data.coverArtPath,
      createdAt: data.createdAt,
    );
  }

  factory PlaylistsModel.fromEntity(PlaylistsEntity entity) {
    return PlaylistsModel(
      id: entity.id,
      name: entity.name,
      coverArtPath: entity.coverArtPath,
      createdAt: entity.createdAt,
    );
  }

  PlaylistsEntity toEntity() {
    return PlaylistsEntity(
      id: id,
      name: name,
      coverArtPath: coverArtPath,
      createdAt: createdAt,
    );
  }
}

extension PlaylistsModelX on List<PlaylistsModel> {
  List<PlaylistsEntity> toEntityList() => map((e) => e.toEntity()).toList();
}
