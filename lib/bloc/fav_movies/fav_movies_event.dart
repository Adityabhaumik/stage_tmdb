part of 'fav_movies_bloc.dart';

sealed class FavMoviesEvent extends Equatable {
  const FavMoviesEvent();

  @override
  List<Object> get props => [];
}

class AddFavMovieEvent extends FavMoviesEvent {
  final Movie movie;

  const AddFavMovieEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movie)';
}

class RemoveMovieEvent extends FavMoviesEvent {
  final Movie movie;

  const RemoveMovieEvent({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movie)';
}

class RetriveSavedMoviesEvent extends FavMoviesEvent {}

class AddAllFavMoviesEvent extends FavMoviesEvent {
  final List<Movie> movies;

  const AddAllFavMoviesEvent({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movies)';
}
