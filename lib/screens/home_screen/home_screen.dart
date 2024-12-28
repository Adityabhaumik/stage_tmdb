import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/fav_movies/fav_movies_bloc.dart';

import 'package:tmdb/bloc/home_screen_state_bloc/home_screen_state_bloc_bloc.dart';
import 'package:tmdb/bloc/movies_bloc/movies_bloc.dart';
import 'package:tmdb/screens/home_screen/utils/movie_card.dart';

import '../../bloc/net_state/net_state_bloc_bloc.dart';
import '../../models/movie_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showFavourite = false;
  final focusNode = FocusNode();
  List<Movie> searchResult = [];
  @override
  void initState() {
    // TODO: implement initState
    context.read<NetStateBlocBloc>().add(CheckNetStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final homeScreenState = context.watch<HomeScreenStateBlocBloc>();
    final favMoviesBolc = context.watch<FavMoviesBloc>();
    final netState = context.watch<NetStateBlocBloc>();

    if (homeScreenState.state.isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (netState.state.state == NetState.notAvailable) {
      return Scaffold(
        appBar: AppBar(
          title: Text("No Internet"),
        ),
        body: Builder(builder: (context) {
          return offlineSavedMovies(context);
        }),
      );
    } else if (netState.state.state == NetState.available) {
      return Scaffold(
        appBar: AppBar(
            title: const Text("Stage Tbmd"),
            actions: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Text("Show Fav"),
                    Switch(
                      value: showFavourite,
                      onChanged: (value) {
                        setState(() {
                          showFavourite = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: showFavourite == true
                  ? const Size.fromHeight(0)
                  : const Size.fromHeight(100),
              child: showFavourite == true
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: focusNode,
                        onChanged: (val) {
                          final filtered = context
                              .read<MoviesBloc>()
                              .state
                              .movies
                              .where((item) {
                            return item.movieTitle
                                .toLowerCase()
                                .contains(val.toLowerCase());
                          }).toList();

                          setState(() {
                            searchResult = filtered;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
            )),
        body: Builder(builder: (context) {
          if (focusNode.hasFocus) {
            if (searchResult.isEmpty) {
              return const Center(
                child: Text("No Such Item"),
              );
            }
            return searchResultView(favMoviesBolc);
          }
          if (showFavourite == true) {
            return onLineFavMovies(context);
          }
          return allMovies(favMoviesBolc);
        }),
      );
    }
    return const SizedBox();
  }

  GridView offlineSavedMovies(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.5),
        itemCount: context.read<FavMoviesBloc>().state.movies.length,
        itemBuilder: (context, index) {
          Movie thisMovie = context.read<FavMoviesBloc>().state.movies[index];
          return Container(
            padding: const EdgeInsets.all(2),
            child: Center(
                child: MovieCard(
              showSavedData: true,
              favHandler: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Action Could not be completed! Connect to Internet',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              movieGenere: thisMovie.genere,
              isFav: thisMovie.isFav,
              movieTitle: thisMovie.movieTitle,
              bannerImgUrl: thisMovie.savedImagePath ?? thisMovie.bannerImgUrl,
            )),
          );
        });
  }

  Builder allMovies(FavMoviesBloc favMoviesBolc) {
    return Builder(builder: (context) {
      if (context.read<MoviesBloc>().state.movies.isEmpty) {
        return const Center(
          child: Text("Failed to Retrive Movies"),
        );
      }
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.5),
          itemCount: context.read<MoviesBloc>().state.movies.length,
          itemBuilder: (context, index) {
            Movie thisMovie = context.read<MoviesBloc>().state.movies[index];

            bool isMoviePresent = favMoviesBolc.state.movies
                .any((movie) => movie.movieTitle == thisMovie.movieTitle);
            if (isMoviePresent == true) {
              thisMovie = thisMovie.copyWith(isFav: true);
            }
            return Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: MovieCard(
                favHandler: () {
                  if (thisMovie.isFav == true) {
                    context
                        .read<FavMoviesBloc>()
                        .add(RemoveMovieEvent(movie: thisMovie));
                  } else {
                    context
                        .read<FavMoviesBloc>()
                        .add(AddFavMovieEvent(movie: thisMovie));
                  }
                },
                movieGenere: thisMovie.genere,
                isFav: thisMovie.isFav,
                movieTitle: thisMovie.movieTitle,
                bannerImgUrl: thisMovie.bannerImgUrl,
              )),
            );
          });
    });
  }

  GridView onLineFavMovies(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.5),
        itemCount: context.read<FavMoviesBloc>().state.movies.length,
        itemBuilder: (context, index) {
          Movie thisMovie = context.read<FavMoviesBloc>().state.movies[index];
          return Container(
            padding: const EdgeInsets.all(2),
            child: Center(
                child: MovieCard(
              showSavedData: true,
              favHandler: () {
                if (thisMovie.isFav == true) {
                  context
                      .read<FavMoviesBloc>()
                      .add(RemoveMovieEvent(movie: thisMovie));
                } else {
                  context
                      .read<FavMoviesBloc>()
                      .add(AddFavMovieEvent(movie: thisMovie));
                }
              },
              movieGenere: thisMovie.genere,
              isFav: thisMovie.isFav,
              movieTitle: thisMovie.movieTitle,
              bannerImgUrl: thisMovie.savedImagePath ?? thisMovie.bannerImgUrl,
            )),
          );
        });
  }

  GridView searchResultView(FavMoviesBloc favMoviesBolc) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.5),
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          Movie thisMovie = searchResult[index];
          if (showFavourite == false) {
            bool isMoviePresent = favMoviesBolc.state.movies
                .any((movie) => movie.movieTitle == thisMovie.movieTitle);
            if (isMoviePresent == true) {
              thisMovie = thisMovie.copyWith(isFav: true);
            }
          }
          return Container(
            padding: const EdgeInsets.all(2),
            child: Center(
                child: MovieCard(
              showSavedData: false,
              favHandler: () {
                if (thisMovie.isFav == true) {
                  context
                      .read<FavMoviesBloc>()
                      .add(RemoveMovieEvent(movie: thisMovie));
                } else {
                  context
                      .read<FavMoviesBloc>()
                      .add(AddFavMovieEvent(movie: thisMovie));
                }
              },
              movieGenere: thisMovie.genere,
              isFav: thisMovie.isFav,
              movieTitle: thisMovie.movieTitle,
              bannerImgUrl: thisMovie.savedImagePath ?? thisMovie.bannerImgUrl,
            )),
          );
        });
  }
}
