part of 'fav_movies_bloc.dart';

sealed class FavMoviesEvent extends Equatable {
  const FavMoviesEvent();

  @override
  List<Object> get props => [];
}

class AddFavMovie extends FavMoviesEvent {
  final Movie movie;

  const AddFavMovie({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movie)';
}

class RemoveMovie extends FavMoviesEvent {
  final Movie movie;

  const RemoveMovie({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'ToggleHomeScreenLoadingState(isLoading: $movie)';
}
