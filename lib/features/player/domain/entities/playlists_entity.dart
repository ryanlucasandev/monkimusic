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

  @override
  List<Object?> get props => [id, name, coverArtPath, createdAt];
}
