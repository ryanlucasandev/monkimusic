import 'package:monkimusic/features/songs/data/datasources/songs_local_datasource.dart';
import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';
import 'package:monkimusic/features/songs/domain/repositories/songs_repository.dart';

class SongsRepositoryImpl implements SongsRepository {
  final SongsLocalDataSource _localDataSource;

  SongsRepositoryImpl(this._localDataSource);

  @override
  Future<List<SongsEntity>> fetchDeviceSongs() async {
    return await _localDataSource.fetchDeviceSongs();
  }
}
