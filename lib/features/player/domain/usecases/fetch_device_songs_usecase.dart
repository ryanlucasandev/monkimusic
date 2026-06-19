import 'package:monkimusic/core/usecases/usecase.dart';
import 'package:monkimusic/features/player/domain/entities/songs_entity.dart';
import 'package:monkimusic/features/player/domain/repositories/songs_repository.dart';

class FetchDeviceSongsUseCase implements UseCase<List<SongsEntity>, NoParams> {
  final SongsRepository _repository;
  FetchDeviceSongsUseCase(this._repository);

  @override
  Future<List<SongsEntity>> call(NoParams params) async {
    final songs = await _repository.fetchDeviceSongs();

    songs.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );

    return songs;
  }
}
