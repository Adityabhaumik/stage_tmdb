import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/constants/tmdb.dart';

import '../../models/movie_model.dart';

mixin FavMovieHelper {
  Future<String?> saveNetworkImageWithHttp(
      String imageUrl, String fileName) async {
    try {
      final response = await http.get(Uri.parse('$kTmdbImageBaseUrl$imageUrl'));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();

        final filePath = '${directory.path}/$fileName.jpg';

        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return filePath;
      }
      return null;
    } catch (e) {
      print("Error saving image: $e");
      return null;
    }
  }

  Future<void> saveFavMovieList(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataToSave = [];
    for (Movie mov in movies) {
      String imgPath =
          await saveNetworkImageWithHttp(mov.bannerImgUrl, '${mov.id}.jpg') ??
              "";
      String thisMovie = mov.saveFormat(imgPath);
      dataToSave.add(thisMovie);
    }
    await prefs.setStringList("favMovies", dataToSave);
  }

  Future<List<Movie>> getSavedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedData = prefs.getStringList("favMovies");
    List<Movie> savedMovies = [];
    for (String str in savedData ?? []) {
      Movie thisMovie = Movie.retrive(str);
      savedMovies.add(thisMovie);
    }
    return savedMovies;
  }
}
