import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/item_list/item_cast.dart';
import 'package:movie_app/components/item_list/item_videos.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';
import 'package:movie_app/resources/strings/resource_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../item_list/item_movie_grid.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen(this.movieId);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final _movieRepository = MovieRepository();
  MovieDetail _movieDetail;
  List<Movie> _similarMovieList = [];
  List<Movie> _recommendationMovieList = [];
  List<Cast> _casts = [];
  List<MovieVideo> _videos = [];
  bool _gettingMovieDetail = false;
  bool _fetchingSimilarMovies = false;
  bool _fetchingRecommendationMovies = false;
  bool _gettingCastMovies = false;
  bool _findingVideos = false;
  bool _isScrollLimitReached = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget?.movieId != null) {
      _getMovieDetail(widget.movieId);
      _fetchSimilarMovies(widget.movieId);
      _fetchRecommendationMovies(widget.movieId);
      _getCredit(widget.movieId);
      _findVideos(widget.movieId);
    }
    _initScrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildMovieDetail());
  }

  Widget _buildMovieDetail() {
    String year;
    if (_movieDetail?.releaseDate?.isNotEmpty == true) {
      year = _movieDetail?.releaseDate?.substring(0, 4);
    } else {
      year = "";
    }
    if (_gettingMovieDetail) {
      return Center(child: AppLoading.spinkitDualRingLoading());
    } else {
      if (_movieDetail == null) {
        return Center(child: Text(ResourceStrings.err_failed_to_fetch_movie));
      } else {
        return CustomScrollView(controller: _scrollController, slivers: [
          SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              title: Padding(
                padding: !_isScrollLimitReached
                    ? const EdgeInsetsDirectional.only(start: 50, end: 50)
                    : const EdgeInsetsDirectional.only(start: 10, end: 10),
                child: Visibility(
                  visible: !_isScrollLimitReached,
                  child: Text(
                    _movieDetail?.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              background: _movieDetail?.backdropPath != null
                  ? Image.network(
                      Const.baseUrlImage + _movieDetail?.backdropPath,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    )
                  : _buildImagePlaceHolder(),
            ),
            pinned: true,
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimens.default_vertical_padding,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                  child: Visibility(
                    visible: _isScrollLimitReached,
                    child: Center(
                      child: Text(
                        _movieDetail?.title,
                        style: TextStyle(
                          fontSize: Dimens.extra_large_font_size,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.amberAccent,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: Dimens.default_vertical_padding)),
                        Text(
                            "${_movieDetail?.voteAverage?.toString()}/${_movieDetail?.voteCount?.toString()}")
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.amberAccent,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: Dimens.default_vertical_padding)),
                        Text(year)
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.amberAccent,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: Dimens.default_vertical_padding)),
                        Text(_convertRuntimeToDuration(_movieDetail?.runtime))
                      ],
                    )
                  ],
                ),
                SizedBox(height: Dimens.default_padding),
                _buildOverview(),
                SizedBox(height: Dimens.default_padding),
                SizedBox(height: Dimens.default_padding),
                _buildCastMovies(),
                _buildVideos(),
                _buildSimilarMovies(),
                _buildRecommendationMovies(),
              ],
            ),
          )
        ]);
      }
    }
  }

  Widget _buildVideos() {
    if (_findingVideos) {
      return AppLoading.spinkitDualRingLoading();
    } else {
      if (_videos.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Dimens.default_padding,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimens.default_horizontal_padding),
              child: Text(
                "Videos",
                style: TextStyle(fontSize: Dimens.extra_large_font_size),
              ),
            ),
            SizedBox(
              height: Dimens.default_padding,
            ),
            Container(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ItemVideos(_videos, index),
                    onTap: () {
                      var url = Const.generateYoutubeVideoUrl(_videos[index].key);
                      _launchBrowser(url);
                    },
                  );
                },
                itemCount: _videos.length,
              ),
            )
          ],
        );
      } else {
        return Container();
      }
    }
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.default_horizontal_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimens.default_padding,
          ),
          Text(
            ResourceStrings.overview,
            style: TextStyle(fontSize: Dimens.extra_large_font_size),
          ),
          SizedBox(
            height: Dimens.default_padding,
          ),
          Text(_movieDetail?.overview),
        ],
      ),
    );
  }

  Widget _buildImagePlaceHolder() {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        height: 748,
        width: 500,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCastMovies() {
    if (_gettingCastMovies) {
      return AppLoading.spinkitDualRingLoading();
    } else {
      if (_casts != null && _casts?.isNotEmpty == true) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.default_horizontal_padding),
              child: Text(
                ResourceStrings.cast,
                style: TextStyle(fontSize: Dimens.extra_large_font_size),
              ),
            ),
            SizedBox(height: Dimens.default_vertical_padding),
            Container(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ItemCast(_casts, index),
                    onTap: () {
                      // Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                      //     arguments: {
                      //       AppArguments.movieId: _similarMovieList[index]?.id
                      //     });
                    },
                  );
                },
                itemCount: _casts.length,
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    }
  }

  Widget _buildSimilarMovies() {
    if (_fetchingSimilarMovies) {
      return AppLoading.spinkitDualRingLoading();
    } else {
      if (_similarMovieList != null && _similarMovieList?.isNotEmpty == true) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.default_horizontal_padding),
              child: Text(
                ResourceStrings.similar_movies,
                style: TextStyle(fontSize: Dimens.extra_large_font_size),
              ),
            ),
            SizedBox(height: Dimens.default_padding),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ItemMovieGrid(_similarMovieList, index),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                          arguments: {
                            AppArguments.movieId: _similarMovieList[index]?.id
                          });
                    },
                  );
                },
                itemCount: _similarMovieList.length,
              ),
            )
          ],
        );
      } else {
        return Container();
      }
    }
  }

  Widget _buildRecommendationMovies() {
    if (_fetchingRecommendationMovies) {
      return AppLoading.spinkitDualRingLoading();
    } else {
      if (_recommendationMovieList != null &&
          _recommendationMovieList?.isNotEmpty == true) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.default_horizontal_padding),
              child: Text(ResourceStrings.recommendation_movies,
                  style: TextStyle(fontSize: Dimens.extra_large_font_size)),
            ),
            SizedBox(height: Dimens.default_padding),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ItemMovieGrid(_recommendationMovieList, index),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                          arguments: {
                            AppArguments.movieId:
                                _recommendationMovieList[index]?.id
                          });
                    },
                  );
                },
                itemCount: _recommendationMovieList.length,
              ),
            )
          ],
        );
      } else {
        return Container();
      }
    }
  }

  Future<void> _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String _convertRuntimeToDuration(int runtime) {
    if (runtime == null) return "";
    var hour = (runtime / 60).floor();
    var minutes = runtime % 60;
    return "${hour}h ${minutes}min";
  }

  void _initScrollListener() {
    _scrollController.addListener(() {
      final newState = _scrollController.offset <=
          (_scrollController.position.minScrollExtent);

      if (newState != _isScrollLimitReached) {
        setState(() {
          _isScrollLimitReached = newState;
        });
      }
    });
  }

  void _getMovieDetail(int movieId) async {
    setState(() {
      _gettingMovieDetail = true;
    });
    _movieDetail = await _movieRepository.getMovieDetail(movieId);
    setState(() {
      _gettingMovieDetail = false;
    });
  }

  void _fetchSimilarMovies(int movieId) async {
    setState(() {
      _fetchingSimilarMovies = true;
    });
    var result = await _movieRepository.fetchSimilarMovies(movieId);
    setState(() {
      _similarMovieList.addAll(result?.movies);
      _fetchingSimilarMovies = false;
    });
  }

  void _fetchRecommendationMovies(int movieId) async {
    setState(() {
      _fetchingRecommendationMovies = true;
    });
    var result = await _movieRepository.fetchRecommendationMovies(movieId);
    setState(() {
      _recommendationMovieList.addAll(result?.movies);
      _fetchingRecommendationMovies = false;
    });
  }

  void _getCredit(int movieId) async {
    setState(() {
      _gettingCastMovies = true;
    });
    var result = await _movieRepository.getCredit(movieId);
    setState(() {
      _casts.addAll(result.cast);
      _gettingCastMovies = false;
    });
  }

  void _findVideos(int movieId) async {
    setState(() {
      _findingVideos = true;
    });
    var result = await _movieRepository.findVideos(movieId);
    setState(() {
      _videos.addAll(result.results);
      _findingVideos = false;
    });
  }
}
