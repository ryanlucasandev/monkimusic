import 'package:equatable/equatable.dart';

class SongsEntity extends Equatable {
  final int? songId;
  final String? id; // content uri handled by media store
  final String? filePath; // song path for sharing playlists
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
    this.songId,
    this.id,
    this.filePath,
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

  SongsEntity copyWith({
    String? id,
    String? filePath,
    String? title,
    String? artist,
    String? album,
    int? albumId,
    int? artistId,
    Duration? duration,
    int? track,
    String? genre,
    int? dateAdded,
  }) {
    return SongsEntity(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumId: albumId ?? this.albumId,
      artistId: artistId ?? this.artistId,
      duration: duration ?? this.duration,
      track: track ?? this.track,
      genre: genre ?? this.genre,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  @override
  List<Object?> get props => [
    songId,
    id,
    filePath,
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
