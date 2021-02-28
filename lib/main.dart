import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_detail.dart';
import 'package:movie_app/components/movies.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/" : (context) => MoviesScreen(),
      "/detail" : (context) => MovieDetailScreen(),
    },
  ));
}
