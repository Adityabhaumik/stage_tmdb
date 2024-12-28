import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/fav_movies/fav_movies_bloc.dart';

import 'package:tmdb/bloc/home_screen_state_bloc/home_screen_state_bloc_bloc.dart';
import 'package:tmdb/bloc/movies_bloc/movies_bloc.dart';
import 'package:tmdb/constants/tmdb.dart';

import '../../models/movie_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final homeScreenState = context.watch<HomeScreenStateBlocBloc>();
    return Scaffold(
      body: Builder(builder: (context) {
        if (homeScreenState.state.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () async {},
          child: Builder(builder: (context) {
            if (context.read<MoviesBloc>().state.movies.length == 0) {
              return Center(
                child: GestureDetector(
                    onTap: () {
                      context.read<MoviesBloc>().add(FetchMoviesFromApi());
                    },
                    child: Text("get movies")),
              );
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing:
                        2.0, // Horizontal space between grid items
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.5 // Vertical space between grid items
                    ),
                itemCount: context.read<MoviesBloc>().state.movies.length,
                itemBuilder: (context, index) {
                  Movie thisMovie =
                      context.read<MoviesBloc>().state.movies[index];
                  bool isMoviePresent =
                      movies.any((movie) => movie.movieTitle == 'Movie A');
                  return Container(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                        child: MovieCard(
                      favHandler: () {
                        context
                            .read<FavMoviesBloc>()
                            .add(AddFavMovie(movie: thisMovie));
                      },
                      movieGenere:
                          "${kTmdbMovieGenresInverted[thisMovie.genereId[0] ?? "NA"]}",
                      isFav: false,
                      movieTitle: thisMovie.movieTitle,
                      bannerImgUrl: thisMovie.bannerImgUrl,
                    )),
                  );
                });
          }),
        );
      }),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movieTitle,
    required this.movieGenere,
    required this.favHandler,
    required this.bannerImgUrl,
    required this.isFav,
  }) : super(key: key);
  final String movieTitle;
  final String movieGenere;
  final Function favHandler;
  final String bannerImgUrl;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 352,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 275,
            width: 190,
            color: Colors.white,
            child: CachedNetworkImage(
              imageUrl: "$kTmdbImageBaseUrl$bannerImgUrl",
              imageBuilder: (context, imageProvioder) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvioder, fit: BoxFit.fill),
                      ),
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 5.0),
                        child: Container(
                          color: Colors.black.withOpacity(
                              0.4), // Add a semi-transparent overlay
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvioder, fit: BoxFit.contain),
                      ),
                    ),
                  ],
                );
              },
              placeholder: (context, url) => Container(
                height: 250,
                width: 164,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            height: 75,
            width: 190,
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        movieTitle,
                        style: TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(movieGenere)
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    favHandler();
                  },
                  child: Container(
                    child: Icon(
                      Icons.favorite,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



/** */