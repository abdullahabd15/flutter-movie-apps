import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_detail_screen.dart';
import 'package:movie_app/components/movies_screen.dart';
import 'package:movie_app/constants/const.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => onGenerateRoute(settings)));
}

onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoute.initialRoute:
      return MaterialPageRoute(builder: (context) {
        return MoviesScreen();
      });
      break;
    case AppRoute.detailMovieRoute:
      Map args = settings.arguments;
      int id = args[AppArguments.movieId];
      return MaterialPageRoute(builder: (context) {
        return MovieDetailScreen(id);
      });
      break;
    default:
      return null;
  }
}
