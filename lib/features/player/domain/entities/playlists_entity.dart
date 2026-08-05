import 'package:equatable/equatable.dart';

class PlaylistsEntity extends Equatable {
  final int? id;
  final String name;
  final String? coverArtPath;
  final DateTime createdAt;

  const PlaylistsEntity({
    this.id,
    required this.name,
    this.coverArtPath,
    required this.createdAt,
  });

  PlaylistsEntity copyWith({
    int? id,
    String? name,
    String? coverArtPath,
    DateTime? createdAt,
  }) {
    return PlaylistsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      coverArtPath: coverArtPath ?? this.coverArtPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, coverArtPath, createdAt];
}
