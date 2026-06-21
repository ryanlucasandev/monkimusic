import 'package:equatable/equatable.dart';

class SongsEntity extends Equatable {
  final String id;
  final String title;
  final String? artist;
  final Duration? duration;
  const SongsEntity({
    required this.id,
    required this.title,
    this.artist,
    this.duration,
  });

  @override
  List<Object?> get props => [id, title, artist, duration];
}
