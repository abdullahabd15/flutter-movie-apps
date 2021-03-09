import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/screens/all_movies_screen.dart';
import 'package:movie_app/components/item_list/item_movie_grid.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';
import 'package:movie_app/resources/strings/resource_strings.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final _repository = MovieRepository();
  List<Movie> _topMovies;
  bool _topMoviesLoading = false;
  List<Movie> _popularMovies;
  bool _popularMoviesLoading = false;

  @override
  void initState() {
    super.initState();
    _findTopRatedMovies();
    _findPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    String topRatedCategory = ResourceStrings.top_rated_movies;
    String popularCategory = ResourceStrings.popular_movies;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(ResourceStrings.app_name)),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _createHeaderList(topRatedCategory, () {
                String movieCategory = ResourceStrings.top_rated_key;
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments: AllMoviesScreen(movieCategory, topRatedCategory));
              }),
              _createTopRatedMovies(_topMovies, (Movie movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
              _createHeaderList(popularCategory, () {
                String movieCategory = ResourceStrings.popular_key;
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments: AllMoviesScreen(movieCategory, popularCategory));
              }),
              _createPopularMovies(_popularMovies, (Movie movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
            ],
          ),
        ));
  }

  Widget _createPopularMovies(List<Movie> movies, Function onItemClicked) {
    if (_popularMoviesLoading) {
      return Center(child: AppLoading.spinkitCircleLoading());
    } else {
      if (movies != null) {
        return _createMovieList(movies, (Movie movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Center(child: Text(ResourceStrings.err_failed_to_fetch_movie));
      }
    }
  }

  Widget _createTopRatedMovies(List<Movie> movies, Function onItemClicked) {
    if (_topMoviesLoading) {
      return Center(child: AppLoading.spinkitCircleLoading());
    } else {
      if (movies != null) {
        return _createMovieList(movies, (Movie movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Center(
          child: Text(ResourceStrings.err_failed_to_fetch_movie),
        );
      }
    }
  }

  Widget _createMovieList(List<Movie> movies, Function onItemListClicked) {
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
            style: TextStyle(fontSize: Dimens.extra_large_font_size),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.default_padding),
                    child: Text(ResourceStrings.view_all),
                  ),
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
    _popularMovies = result.movies.sublist(0, 5);
    setState(() {
      _popularMoviesLoading = false;
    });
  }

  void _findTopRatedMovies() async {
    setState(() {
      _topMoviesLoading = true;
    });
    var result = await _repository.findTopRatedMovies(1);
    _topMovies = result.movies.sublist(0, 5);
    setState(() {
      _topMoviesLoading = false;
    });
  }
}