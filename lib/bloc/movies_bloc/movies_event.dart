part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesFromApi extends MoviesEvent {}

class AddAllMoviesEvent extends MoviesEvent {
  final List<Movie> movies;

  const AddAllMoviesEvent({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movies)';
}
