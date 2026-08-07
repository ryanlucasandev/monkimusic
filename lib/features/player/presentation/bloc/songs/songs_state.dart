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
  final List<SongsEntity> filteredSongs;
  final Set<SongsEntity> selectedSongs;
  final bool isSelectingSongs;
  final String searchQuery;
  const SongsLoaded({
    this.allSongs = const <SongsEntity>[],
    this.filteredSongs = const <SongsEntity>[],
    this.selectedSongs = const {},
    this.isSelectingSongs = false,
    this.searchQuery = '',
  });

  SongsLoaded copyWith({
    List<SongsEntity>? allSongs,
    List<SongsEntity>? filteredSongs,
    Set<SongsEntity>? selectedSongs,
    bool? isSelectingSongs,
    String? searchQuery,
  }) {
    return SongsLoaded(
      allSongs: allSongs ?? this.allSongs,
      filteredSongs: filteredSongs ?? this.filteredSongs,
      selectedSongs: selectedSongs ?? this.selectedSongs,
      isSelectingSongs: isSelectingSongs ?? this.isSelectingSongs,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    allSongs,
    filteredSongs,
    selectedSongs,
    isSelectingSongs,
    searchQuery,
  ];
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
