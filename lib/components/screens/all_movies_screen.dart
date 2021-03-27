import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/item_list/item_all_movie_grid.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';
import 'package:movie_app/resources/strings/resource_strings.dart';

class AllMoviesScreen extends StatefulWidget {
  final String category;
  final String categoryMessage;

  AllMoviesScreen(this.category, this.categoryMessage);

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  final _repository = MovieRepository();
  List<Movie> _movies = [];
  bool _isLoading = false;
  int _itemsLength = 0;
  int _currentPage = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    fetchMovies(_currentPage, widget.category);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      fetchMovies(_currentPage, widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryMessage),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              if (_movies?.isEmpty == false)
                _allMoviesWidget()
              else
                Container(),
              Visibility(
                visible: _isLoading,
                child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimens.bottom_screen_padding),
                    child: AppLoading.spinkitDualRingLoading()),
              ),
            ],
          ),
        ));
  }

  Widget _allMoviesWidget() {
    if (_movies != null) {
      return Expanded(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.default_padding),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            controller: _scrollController,
            itemCount: _itemsLength,
            itemBuilder: (context, index) => InkWell(
              child: ItemAllMovieGrid(_movies, index),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                    arguments: {AppArguments.movieId: _movies[index]?.id});
              },
            ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          ),
        ),
      );
    } else if (_movies?.isEmpty == true) {
      return Center(
        child: Text(ResourceStrings.empty_movies),
      );
    } else {
      return Center(
        child: Text(ResourceStrings.err_failed_to_fetch_movie),
      );
    }
  }

  void fetchMovies(int page, String movieCategory) async {
    setState(() {
      _isLoading = true;
    });
    var result = await _repository.fetchMovies(page, movieCategory);
    setState(() {
      _movies?.addAll(result.movies);
      _itemsLength = _movies.length;
      _isLoading = false;
    });
  }
}
