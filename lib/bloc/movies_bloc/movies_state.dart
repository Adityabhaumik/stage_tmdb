part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<Movie> movies;
  const MoviesState({
    required this.movies,
  });

  factory MoviesState.initial() {
    return const MoviesState(movies: []);
  }
  @override
  List<Object> get props => [movies];

  MoviesState copyWith({List<Movie>? movies}) {
    return MoviesState(movies: movies ?? this.movies);
  }

  @override
  bool get stringify => true;
}
