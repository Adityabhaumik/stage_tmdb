import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/bloc/fav_movies/fav_movies_bloc_helper.dart';

import '../../models/movie_model.dart';
import '../home_screen_state_bloc/home_screen_state_bloc_bloc.dart';

part 'fav_movies_event.dart';
part 'fav_movies_state.dart';

class FavMoviesBloc extends Bloc<FavMoviesEvent, FavMoviesState>
    with FavMovieHelper {
  final HomeScreenStateBlocBloc homeScreenStateBlocBloc;
  FavMoviesBloc({required this.homeScreenStateBlocBloc})
      : super(FavMoviesState.initial()) {
    on<AddFavMovieEvent>((event, emit) async {
      List<Movie> newList = [...state.movies];
      Movie newMovie = event.movie.copyWith(isFav: true);
      newList.add(newMovie);
      emit(state.copyWith(movies: newList));
      saveFavMovieList(state.movies);
    });

    on<RemoveMovieEvent>((event, emit) {
      List<Movie> newList = [];
      for (Movie mov in state.movies) {
        if (mov.movieTitle != event.movie.movieTitle) {
          newList.add(mov);
        }
      }
      emit(state.copyWith(movies: newList));
      saveFavMovieList(state.movies);
    });

    on<RetriveSavedMoviesEvent>((event, emit) async {
      List<Movie> newList = await getSavedMovies();
      emit(state.copyWith(movies: newList));
    });

    on<AddAllFavMoviesEvent>((event, emit) async {
      emit(state.copyWith(movies: event.movies));
    });
  }
}
