import 'package:equatable/equatable.dart';

class SongsEntity extends Equatable {
  final int? id; // Drift ID
  final int? mediaId; // Android MediaStore ID

  final String? uri;
  final String? title;
  final String? artist;
  final String? album;

  final int? albumId;
  final int? artistId;

  final Duration? duration;
  final int? track;
  final String? genre;
  final int? dateAdded;

  const SongsEntity({
    this.id,
    this.mediaId,
    this.uri,
    this.title,
    this.artist,
    this.album,
    this.albumId,
    this.artistId,
    this.duration,
    this.track,
    this.genre,
    this.dateAdded,
  });

  @override
  List<Object?> get props => [
    id,
    mediaId,
    uri,
    title,
    artist,
    album,
    albumId,
    artistId,
    duration,
    track,
    genre,
    dateAdded,
  ];
}
