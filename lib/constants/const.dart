class Const {
  static const String apiKey = "a6d3bcc3767f0accbdeede16439380da";
  static const String baseUrl = "https://api.themoviedb.org/3/movie/";
  static const String baseUrlImage = "https://image.tmdb.org/t/p/w500";
  static const String defLang = "en-US";
}

class AppRoute {
  static const String initialRoute = "/";
  static const String detailMovieRoute = "/detailMovie";
  static const String allMoviesRoute = "/allMovies";
}

class AppArguments {
  static const String movieId = "MOVIE_ID";
  static const String movieCategory = "MOVIE_CATEGORY";
  static const String movieCategoryMessage = "MOVIE_CATEGORY_MESSAGE";
}