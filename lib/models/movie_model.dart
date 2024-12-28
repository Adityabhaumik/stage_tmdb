class Movie {
  final String movieTitle;
  final Function favHandler;
  final String bannerImgUrl;
  final bool isFav;
  final List genereId;

  Movie({
    required this.movieTitle,
    required this.genereId,
    required this.favHandler,
    required this.bannerImgUrl,
    required this.isFav,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieTitle: json['title'] ?? '',
      genereId: List.from(json['genre_ids'] ?? []),
      favHandler: () {},
      bannerImgUrl:
          "https://image.tmdb.org/t/p/w500" + (json['backdrop_path'] ?? ''),
      isFav: json['vote_average'] >=
          7.0, // Assuming movie is favorite if vote average is >= 7.0
    );
  }

  @override
  String toString() {
    return 'Movie(title: $movieTitle, genre: $genereId, isFavorite: $isFav)';
  }
}
