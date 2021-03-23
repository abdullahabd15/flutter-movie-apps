class Const {
  static const String apiKey = "a6d3bcc3767f0accbdeede16439380da";
  static const String baseUrlMovies = "https://api.themoviedb.org/3/movie/";
  static const String baseUrlSearch = "https://api.themoviedb.org/3/search/movie";
  static const String baseUrlImage = "https://image.tmdb.org/t/p/w500";
  static const String defLang = "en-US";

  static String generateYoutubeImageThumbnail(String youtubeId) {
    return "https://img.youtube.com/vi/$youtubeId/0.jpg";
  }

  static String generateYoutubeVideoUrl(String youtubeId) {
    return "https://www.youtube.com/watch?v=$youtubeId";
  }
}

class AppRoute {
  static const String initialRoute = "/";
  static const String detailMovieRoute = "/detailMovie";
  static const String allMoviesRoute = "/allMovies";
  static const String searchMovies = "/searchMovies";
  static const String loginRoute = "/login";
}

class AppArguments {
  static const String movieId = "MOVIE_ID";
  static const String movieCategory = "MOVIE_CATEGORY";
  static const String movieCategoryMessage = "MOVIE_CATEGORY_MESSAGE";
}