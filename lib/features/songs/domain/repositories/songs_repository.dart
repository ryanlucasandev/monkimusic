import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';

abstract class SongsRepository {
  Future<List<SongsEntity>> fetchDeviceSongs();
}
