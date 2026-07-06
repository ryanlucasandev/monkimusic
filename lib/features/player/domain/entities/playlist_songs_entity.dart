import 'package:equatable/equatable.dart';

class PlaylistSongsEntity extends Equatable {
  final int playlistId;
  final int songId;
  final int position;

  const PlaylistSongsEntity({
    required this.playlistId,
    required this.songId,
    required this.position,
  });

  @override
  List<Object?> get props => [playlistId, songId, position];
}
