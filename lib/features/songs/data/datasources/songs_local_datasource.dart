import 'package:on_audio_query_forked/on_audio_query.dart';

abstract class SongsLocalDataSource {
  Future<List<SongModel>> fetchDeviceSongs();
}

class SongsLocalDataSourceImpl extends SongsLocalDataSource {
  final OnAudioQuery _audioQuery;
  SongsLocalDataSourceImpl(this._audioQuery);

  @override
  Future<List<SongModel>> fetchDeviceSongs() async {
    bool hasPermission = await _audioQuery.checkAndRequest(retryRequest: true);
    if (!hasPermission) throw Exception('Storage permission denied');
    return await _audioQuery.querySongs();
  }
}
