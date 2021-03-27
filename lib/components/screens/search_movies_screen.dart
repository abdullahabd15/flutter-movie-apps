import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/item_list/item_all_movie_grid.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';
import 'package:movie_app/utils/keyboard_utils.dart';

class SearchMoviesScreen extends StatefulWidget {
  @override
  _SearchMoviesScreenState createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  final MovieRepository _movieRepository = MovieRepository();
  int _totalPage = 1;
  ScrollController _scrollController;
  List<Movie> _movies = [];
  String _searchQuery = "";
  String _currentSearchQuery = "";
  int _itemsLength = 0;
  int _currentPage = 1;
  bool _searchLoading = false;
  bool _pageLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_searchLoading) {
      return Container(
        child: Center(
          child: AppLoading.spinkitDualRingLoading(),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            if (_movies?.isNotEmpty == true)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.default_horizontal_padding),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    controller: _scrollController,
                    itemCount: _itemsLength,
                    itemBuilder: (context, index) => InkWell(
                      child: ItemAllMovieGrid(_movies, index),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoute.detailMovieRoute, arguments: {
                          AppArguments.movieId: _movies[index]?.id
                        });
                      },
                    ),
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  ),
                ),
              )
            else
              Container(),
            Visibility(
              visible: _pageLoading,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  AppLoading.spinkitDualRingLoading(),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (text) {
        _searchQuery = text;
      },
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            _currentPage = 1;
            _movies = [];
            setState(() {
              _searchLoading = true;
            });
            _doSearchMovies(_currentPage);
            KeyboardUtils.hideSoftInputKeyboard(context);
          })
    ];
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        _currentPage < _totalPage) {
      _currentPage++;
      setState(() {
        _pageLoading = true;
      });
      _doSearchMovies(_currentPage);
    }
  }

  void _doSearchMovies(int page) async {
    if (_searchQuery != null && _searchQuery.isNotEmpty) {
      if (_currentSearchQuery != _searchQuery) {
        _movies.clear();
        _currentSearchQuery = _searchQuery;
      }
      var searchResults =
          await _movieRepository.searchMovies(_searchQuery, page);
      setState(() {
        _searchLoading = false;
        _pageLoading = false;
        _movies.addAll(searchResults?.movies);
        _totalPage = searchResults?.totalPages ?? 1;
        _itemsLength = _movies.length;
      });
    }
  }
}
