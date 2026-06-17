import 'package:monkimusic/features/songs/data/datasources/songs_local_datasource.dart';
import 'package:monkimusic/features/songs/domain/entities/song_entity.dart';
import 'package:monkimusic/features/songs/domain/repositories/songs_repository.dart';

class SongsRepositoryImpl implements SongsRepository {
  final SongsLocalDataSource _localDataSource;

  SongsRepositoryImpl(this._localDataSource);

  @override
  Future<List<SongsEntity>> fetchDeviceSongs() async {
    final songs = await _localDataSource.fetchDeviceSongs();

    return songs
        .where((song) => song.isMusic == true)
        .map(
          (song) => SongsEntity(
            id: song.uri ?? song.id.toString(),
            title: song.title,
            artist: song.artist,
            duration: Duration(milliseconds: song.duration!),
          ),
        )
        .toList();
  }
}
