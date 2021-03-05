import 'package:flutter/material.dart';
import 'package:movie_app/movie_app_routing.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => MovieAppRouting.onGenerateRoute(settings)))
  ;
}