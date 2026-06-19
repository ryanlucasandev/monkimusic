import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/features/player/domain/repositories/audio_player_repository.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';

class InitSongsUsecase implements UseCase<void, List<SongsEntity>> {
  final AudioPlayerRepository _repository;
  InitSongsUsecase(this._repository);

  @override
  Future<void> call(List<SongsEntity> params) async {
    return await _repository.initSongs(params);
  }
}
