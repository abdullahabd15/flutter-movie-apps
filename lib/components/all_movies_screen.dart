import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/components/item_list/item_all_movie_grid.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_model.dart';

class AllMoviesScreen extends StatefulWidget {
  final String category;
  final String categoryMessage;

  AllMoviesScreen(this.category, this.categoryMessage);

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  final _repository = MovieRepository();
  List<Results> _movies = List();
  bool _isLoading = false;
  int _itemsLength = 0;
  int _currentPage = 1;

  @override
  void initState() {
    fetchMovies(_currentPage, widget.category);
    super.initState();
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
              if (_movies?.isEmpty == false) _allMoviesWidget() else Container(),
              Visibility(
                visible: _isLoading,
                child: SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ));
  }

  Widget _allMoviesWidget() {
    if (_movies != null) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NotificationListener(
            onNotification: (ScrollNotification scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent) {
                _currentPage++;
                fetchMovies(_currentPage, widget.category);
              }
              return true;
            },
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 5.3,
                children: List.generate(_itemsLength, (index) {
                  return InkWell(
                    child: ItemAllMovieGrid(_movies, index),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.detailMovieRoute,
                          arguments: {
                            AppArguments.movieId: _movies[index]?.id
                          });
                    },
                  );
                })),
          ),
        ),
      );
    } else if (_movies?.isEmpty == true) {
      return Center(
        child: Text("Movies is empty"),
      );
    } else {
      return Center(
        child: Text("Failed to fetch movies"),
      );
    }
  }

  void fetchMovies(int page, String movieCategory) async {
    setState(() {
      _isLoading = true;
    });
    var result = await _repository.fetchMovies(page, movieCategory);
    setState(() {
      _movies?.addAll(result.results);
      _itemsLength = _movies.length;
      _isLoading = false;
    });
  }
}
