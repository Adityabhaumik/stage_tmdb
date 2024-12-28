class Movie {
  final String id;
  final String movieTitle;
  final String bannerImgUrl;
  final String? savedImagePath;
  final bool isFav;
  final String genere;

  Movie(
      {required this.id,
      required this.movieTitle,
      required this.genere,
      required this.bannerImgUrl,
      required this.isFav,
      this.savedImagePath});

  @override
  String toString() {
    return 'Movie(title: $movieTitle, genre: $genere, isFavorite: $isFav , bannerImage : $bannerImgUrl, savedImagePath :$savedImagePath)';
  }

  String saveFormat(String imgPath) {
    return '$id;;$movieTitle;;$genere;;$isFav;;$bannerImgUrl;;$imgPath';
  }

  static Movie retrive(String data) {
    List dataItems = data.split(";;");
    bool isFavForData = false;
    if (dataItems[3] == "true") {
      isFavForData = true;
    }
    Movie movie = Movie(
        id: dataItems[0] ?? "NA",
        movieTitle: dataItems[1] ?? "NA",
        genere: dataItems[2] ?? "NA",
        bannerImgUrl: dataItems[4] ?? "",
        savedImagePath: dataItems[5] ?? "",
        isFav: isFavForData);
    return movie;
  }

  Movie copyWith({
    String? movieTitle,
    Function? favHandler,
    String? bannerImgUrl,
    bool? isFav,
    String? genere,
  }) {
    return Movie(
      id: id,
      movieTitle: movieTitle ?? this.movieTitle,
      bannerImgUrl: bannerImgUrl ?? this.bannerImgUrl,
      isFav: isFav ?? this.isFav,
      genere: genere ?? this.genere,
    );
  }
}
