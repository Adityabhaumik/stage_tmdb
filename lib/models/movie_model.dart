// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Movie copyWith({
    String? movieTitle,
    Function? favHandler,
    String? bannerImgUrl,
    bool? isFav,
    List? genereId,
  }) {
    return Movie(
      movieTitle: movieTitle ?? this.movieTitle,
      favHandler: favHandler ?? this.favHandler,
      bannerImgUrl: bannerImgUrl ?? this.bannerImgUrl,
      isFav: isFav ?? this.isFav,
      genereId: genereId ?? this.genereId,
    );
  }
}
