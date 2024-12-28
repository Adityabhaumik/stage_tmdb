import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_state_bloc_event.dart';
part 'home_screen_state_bloc_state.dart';

class HomeScreenStateBlocBloc
    extends Bloc<HomeScreenStateBlocEvent, HomeScreenStateBlocState> {
  HomeScreenStateBlocBloc() : super(HomeScreenStateBlocState.initial()) {
    on<ToggleHomeScreenLoadingState>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
  }
}
