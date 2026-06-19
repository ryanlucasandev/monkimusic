import 'package:monkimusic/features/songs/domain/entities/songs_entity.dart';

abstract class SongsRepository {
  Future<List<SongsEntity>> fetchDeviceSongs();
}
