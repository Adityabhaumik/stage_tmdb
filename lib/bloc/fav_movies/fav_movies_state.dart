part of 'fav_movies_bloc.dart';

class FavMoviesState extends Equatable {
  final List<Movie> movies;
  const FavMoviesState({
    required this.movies,
  });

  factory FavMoviesState.initial() {
    return const FavMoviesState(movies: []);
  }

  @override
  List<Object> get props => [movies];

  FavMoviesState copyWith({
    List<Movie>? movies,
  }) {
    return FavMoviesState(
      movies: movies ?? this.movies,
    );
  }
}
