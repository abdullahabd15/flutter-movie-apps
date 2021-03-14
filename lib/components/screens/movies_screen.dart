import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/item_list/item_movie_grid.dart';
import 'package:movie_app/components/screens/all_movies_screen.dart';
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
  List<Movie> _topMovies = [];
  bool _topMoviesLoading = false;
  List<Movie> _popularMovies = [];
  bool _popularMoviesLoading = false;
  List<Movie> _upcomingMovies = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _findTopRatedMovies();
    _findPopularMovies();
    _findUpcomingMoviesBanner();
  }

  @override
  Widget build(BuildContext context) {
    String topRatedCategory = ResourceStrings.top_rated_movies;
    String popularCategory = ResourceStrings.popular_movies;
    return Scaffold(
        appBar: AppBar(
          title: Text(ResourceStrings.app_name),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoute.searchMovies);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUpcomingMovies(),
              SizedBox(
                height: Dimens.default_vertical_padding,
              ),
              _buildHeaderList(topRatedCategory, () {
                String movieCategory = ResourceStrings.top_rated_key;
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments:
                        AllMoviesScreen(movieCategory, topRatedCategory));
              }),
              _buildTopRatedMovies(_topMovies, (Movie movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
              _buildHeaderList(popularCategory, () {
                String movieCategory = ResourceStrings.popular_key;
                Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                    arguments: AllMoviesScreen(movieCategory, popularCategory));
              }),
              _buildPopularMovies(_popularMovies, (Movie movie) {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: movie?.id});
              }),
            ],
          ),
        ));
  }

  Widget _buildUpcomingMovies() {
    if (_upcomingMovies.isNotEmpty) {
      String upcomingMovies = ResourceStrings.upcoming_movies;
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, _) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
              items: _imageSliders(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.default_horizontal_padding,
                right: Dimens.default_padding,
                top: Dimens.default_vertical_padding,
                bottom: Dimens.default_vertical_padding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SliderIndicator(
                    length: _upcomingMovies.length,
                    activeIndex: currentIndex,
                    indicator: _circleShape(6.0),
                    activeIndicator: _circleShape(12.0),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.default_padding),
                      child: Text(
                          "${ResourceStrings.view_all} ${ResourceStrings.upcoming_movies}"),
                    ),
                    onTap: () {
                      String movieCategory = ResourceStrings.upcoming;
                      Navigator.of(context).pushNamed(AppRoute.allMoviesRoute,
                          arguments:
                              AllMoviesScreen(movieCategory, upcomingMovies));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  List<Widget> _imageSliders() {
    return _upcomingMovies
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                            "${Const.baseUrlImage}${item.backdropPath}",
                            fit: BoxFit.cover,
                            width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  Widget _buildPopularMovies(List<Movie> movies, Function onItemClicked) {
    if (_popularMoviesLoading) {
      return Center(child: AppLoading.spinkitCircleLoading());
    } else {
      if (movies != null) {
        return _buildMovieList(movies, (Movie movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Center(child: Text(ResourceStrings.err_failed_to_fetch_movie));
      }
    }
  }

  Widget _buildTopRatedMovies(List<Movie> movies, Function onItemClicked) {
    if (_topMoviesLoading) {
      return Center(child: AppLoading.spinkitCircleLoading());
    } else {
      if (movies != null) {
        return _buildMovieList(movies, (Movie movie) {
          onItemClicked.call(movie);
        });
      } else {
        return Center(
          child: Text(ResourceStrings.err_failed_to_fetch_movie),
        );
      }
    }
  }

  Widget _buildMovieList(List<Movie> movies, Function onItemListClicked) {
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

  Widget _buildHeaderList(String title, Function onViewAllClicked) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.default_horizontal_padding,
        right: Dimens.default_padding,
        top: Dimens.default_vertical_padding,
        bottom: Dimens.default_vertical_padding,
      ),
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

  Widget _circleShape(double size) {
    return Container(
      height: size,
      width: size,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5.0),
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
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

  void _findUpcomingMoviesBanner() async {
    var result = await _repository.findUpcomingMovies(1);
    setState(() {
      _upcomingMovies = result.movies
          .where((element) => element.backdropPath != null)
          .take(5)
          .toList();
    });
  }
}
