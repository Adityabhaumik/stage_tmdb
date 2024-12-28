import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tmdb/bloc/fav_movies/fav_movies_bloc.dart';
import 'package:tmdb/bloc/home_screen_state_bloc/home_screen_state_bloc_bloc.dart';
import 'package:tmdb/bloc/movies_bloc/movies_bloc.dart';
part 'net_state_bloc_event.dart';
part 'net_state_bloc_state.dart';

class NetStateBlocBloc extends Bloc<NetStateBlocEvent, NetStateBlocState> {
  MoviesBloc moviesBloc;
  FavMoviesBloc favMoviesBloc;
  HomeScreenStateBlocBloc homeScreenStateBlocBloc;
  NetStateBlocBloc(
      {required this.favMoviesBloc,
      required this.moviesBloc,
      required this.homeScreenStateBlocBloc})
      : super(NetStateBlocState.intial()) {
    on<CheckNetStatusEvent>((event, emit) async {
      homeScreenStateBlocBloc
          .add(const ToggleHomeScreenLoadingState(isLoading: true));
      bool result = await InternetConnection().hasInternetAccess;
      if (result == true) {
        List res = await Future.wait(
            [favMoviesBloc.getSavedMovies(), moviesBloc.fetchTrendingMovies()]);
        favMoviesBloc.add(AddAllFavMoviesEvent(movies: res[0] ?? []));
        moviesBloc.add(AddAllMoviesEvent(movies: res[1] ?? []));
        emit(state.copyWith(state: NetState.available));
        homeScreenStateBlocBloc
            .add(const ToggleHomeScreenLoadingState(isLoading: false));
      } else {
        List res = await Future.wait([favMoviesBloc.getSavedMovies()]);
        favMoviesBloc.add(AddAllFavMoviesEvent(movies: res[0] ?? []));
        emit(state.copyWith(state: NetState.notAvailable));
        homeScreenStateBlocBloc
            .add(const ToggleHomeScreenLoadingState(isLoading: false));
      }
    });
  }
}
