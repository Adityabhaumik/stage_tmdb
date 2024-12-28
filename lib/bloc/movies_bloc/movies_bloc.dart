import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/bloc/home_screen_state_bloc/home_screen_state_bloc_bloc.dart';
import 'package:tmdb/bloc/movies_bloc/movie_bloc_helper.dart';

import '../../models/movie_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> with MovieBlocHelper {
  final HomeScreenStateBlocBloc homeScreenStateBlocBloc;
  MoviesBloc({required this.homeScreenStateBlocBloc})
      : super(MoviesState.initial()) {
    on<FetchMoviesFromApi>((event, emit) async {
      homeScreenStateBlocBloc
          .add(ToggleHomeScreenLoadingState(isLoading: true));
      final List<Movie> newMovies = await fetchTrendingMovies();
      homeScreenStateBlocBloc
          .add(ToggleHomeScreenLoadingState(isLoading: false));
      emit(state.copyWith(movies: newMovies));
    });
  }
}
