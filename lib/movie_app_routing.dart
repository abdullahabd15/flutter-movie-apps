import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/screens/all_movies_screen.dart';

import 'components/screens/movie_detail_screen.dart';
import 'components/screens/movies_screen.dart';
import 'constants/const.dart';

class MovieAppRouting {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
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
      case AppRoute.allMoviesRoute:
        AllMoviesScreen args = settings.arguments;
        return MaterialPageRoute(builder: (context) {
          return AllMoviesScreen(args.category, args.categoryMessage);
        });
        break;
      default:
        return null;
    }
  }
}