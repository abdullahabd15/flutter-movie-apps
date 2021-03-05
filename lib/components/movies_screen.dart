import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/components/all_movies_screen.dart';
import 'package:movie_app/components/item_list/item_movie_grid.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _repository = MovieRepository();
  List<Results> _topMovies;
  bool _topMoviesLoading = false;
  List<Results> _popularMovies;
  bool _popularMoviesLoading = false;

  @override
  void initState() {
    super.initState();
    _findTopRatedMovies();
    _findPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    String topRatedCategory = "Top Rated Movies";
    String popularCategory = "Popular Movies";
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Movie Apps")),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createHeaderList(topRatedCategory, () {
                String movieCategory = "top_rated";
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments: AllMoviesScreen(movieCategory, topRatedCategory));
              }),
              _createTopRatedMovies(_topMovies, (Results movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
              _createHeaderList(popularCategory, () {
                String movieCategory = "popular";
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments: AllMoviesScreen(movieCategory, popularCategory));
              }),
              _createPopularMovies(_popularMovies, (Results movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
            ],
          ),
        ));
  }

  Widget _createPopularMovies(List<Results> movies, Function onItemClicked) {
    if (_popularMoviesLoading) {
      return Column(
        children: [
          SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ],
      );
    } else {
      if (movies != null) {
        return _createMovieList(movies, (Results movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Column(
          children: [Text("Failed to fetch movie")],
        );
      }
    }
  }

  Widget _createTopRatedMovies(List<Results> movies, Function onItemClicked) {
    if (_topMoviesLoading) {
      return Column(
        children: [
          SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ],
      );
    } else {
      if (movies != null) {
        return _createMovieList(movies, (Results movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Column(
          children: [Text("Failed to fetch movie")],
        );
      }
    }
  }

  Widget _createMovieList(List<Results> movies, Function onItemListClicked) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            child: ItemMovieGrid(movies, index),
            onTap: () {
              onItemListClicked.call(movies[index]);
            },
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _createHeaderList(String title, Function onViewAllClicked) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text("View All"),
                  onTap: () {
                    onViewAllClicked.call();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _findPopularMovies() async {
    setState(() {
      _popularMoviesLoading = true;
    });
    var result = await _repository.findPopularMovies(1);
    _popularMovies = result.results.sublist(0, 5);
    setState(() {
      _popularMoviesLoading = false;
    });
  }

  void _findTopRatedMovies() async {
    setState(() {
      _topMoviesLoading = true;
    });
    var result = await _repository.findTopRatedMovies(1);
    _topMovies = result.results.sublist(0, 5);
    setState(() {
      _topMoviesLoading = false;
    });
  }
}
