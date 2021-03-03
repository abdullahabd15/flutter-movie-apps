import 'package:flutter/material.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';

import 'item_list/item_movies.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final repository = MovieRepository();
  List<Results> movies;

  @override
  void initState() {
    findTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Movie Apps")),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child:
                        movies == null ? Text("") : ItemMovies(movies[index]),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                          arguments: {AppArguments.movieId: movies[index]?.id});
                    },
                  );
                },
                itemCount: movies == null ? 0 : movies.length,
              ),
            ),
          ],
        ));
  }

  void findMovies() async {
    var result = await repository.findPopularMovies(1);
    movies = result.results;
    setState(() {});
  }

  void findTopRatedMovies() async {
    var result = await repository.findTopRatedMovies(1);
    movies = result.results;
    setState(() {});
  }
}
