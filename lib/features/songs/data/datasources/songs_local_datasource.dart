import 'package:monkimusic/features/songs/data/models/songs_model.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

abstract class SongsLocalDataSource {
  Future<List<SongsModel>> fetchDeviceSongs();
}

class SongsLocalDataSourceImpl extends SongsLocalDataSource {
  final OnAudioQuery _audioQuery;
  SongsLocalDataSourceImpl(this._audioQuery);

  @override
  Future<List<SongsModel>> fetchDeviceSongs() async {
    bool hasPermission = await _audioQuery.checkAndRequest(retryRequest: true);
    if (!hasPermission) throw Exception('Storage permission denied');
    final songs = await _audioQuery.querySongs();

    return songs
        .where((song) => song.isMusic == true)
        .map((song) => SongsModel.fromPackage(song)) // ◄ Map to Data Model here
        .toList();
  }
}
