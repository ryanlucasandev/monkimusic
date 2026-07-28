part of 'songs_bloc.dart';

sealed class SongsState extends Equatable {
  const SongsState();

  @override
  List<Object?> get props => [];
}

final class SongsInitial extends SongsState {
  const SongsInitial();
}

final class SongsLoading extends SongsState {
  const SongsLoading();
}

final class SongsLoaded extends SongsState {
  final List<SongsEntity> allSongs;
  final Set<SongsEntity> selectedSongs;
  final bool isSelectingSongs;
  const SongsLoaded({
    this.allSongs = const <SongsEntity>[],
    this.selectedSongs = const {},
    this.isSelectingSongs = false,
  });

  SongsLoaded copyWith({
    List<SongsEntity>? allSongs,
    Set<SongsEntity>? selectedSongs,
    bool? isSelectingSongs,
  }) {
    return SongsLoaded(
      allSongs: allSongs ?? this.allSongs,
      selectedSongs: selectedSongs ?? this.selectedSongs,
      isSelectingSongs: isSelectingSongs ?? this.isSelectingSongs,
    );
  }

  @override
  List<Object?> get props => [allSongs, selectedSongs, isSelectingSongs];
}

final class SongsEmpty extends SongsState {
  const SongsEmpty();
}

final class SongsFailure extends SongsState {
  final String? errorMessage;
  const SongsFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
