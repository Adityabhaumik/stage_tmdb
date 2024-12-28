import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/fav_movies/fav_movies_bloc.dart';
import 'package:tmdb/bloc/home_screen_state_bloc/home_screen_state_bloc_bloc.dart';
import 'package:tmdb/bloc/movies_bloc/movies_bloc.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenStateBlocBloc>(
          create: (context) => HomeScreenStateBlocBloc(),
        ),
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(
              homeScreenStateBlocBloc: context.read<HomeScreenStateBlocBloc>()),
        ),
        BlocProvider<FavMoviesBloc>(
          create: (context) => FavMoviesBloc(),
        ),
        // BlocProvider<VideoLengthBloc>(
        //   create: (context) => VideoLengthBloc(initialVideoLength: 5),
        // ),
        // BlocProvider<StorageLimitBloc>(
        //   create: (context) => StorageLimitBloc(
        //       storageLimit: 1000,
        //       popUpMessengerBloc: context.read<PopUpMessengerBloc>()),
        //),
      ],
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      }),
    );
  }
}
