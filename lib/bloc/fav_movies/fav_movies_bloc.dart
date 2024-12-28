import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie_model.dart';

part 'fav_movies_event.dart';
part 'fav_movies_state.dart';

class FavMoviesBloc extends Bloc<FavMoviesEvent, FavMoviesState> {
  FavMoviesBloc() : super(FavMoviesState.initial()) {
    on<AddFavMovie>((event, emit) {
      List<Movie> newList = state.movies;
      newList.add(event.movie);
      emit(state.copyWith(movies: newList));
    });

    on<RemoveMovie>((event, emit) {
      List<Movie> newList = [];
      for (Movie mov in state.movies) {
        if (mov != event.movie) {
          newList.add(mov);
        }
      }
      emit(state.copyWith(movies: newList));
    });
  }
}
