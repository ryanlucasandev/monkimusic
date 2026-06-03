import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monkimusic/features/player/presentation/bloc/player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerLoading());
}
