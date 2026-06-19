class SongsEntity {
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
}
