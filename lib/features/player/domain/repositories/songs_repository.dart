import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

abstract class SongsRepository {
  Future<List<SongsEntity>> fetchDeviceSongs();
}
