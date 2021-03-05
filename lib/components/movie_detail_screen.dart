import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/logic/movies_repository.dart';
import 'package:movie_app/models/movie_detail_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen(this.movieId);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final movieRepository = MovieRepository();
  MovieDetail movieDetail;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget?.movieId != null) {
      getMovieDetail(widget.movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var year = movieDetail?.releaseDate?.substring(0, 4);
    Widget widget;
    final loading = SpinKitCircle(
      color: Colors.blue,
      size: 50.0,
    );

    if (isLoading) {
      widget = Center(child: loading);
    } else {
      if (movieDetail == null) {
        widget = widget = Center(child: Text("Failed to fetch movie"));
      } else {
        widget = SingleChildScrollView(
          child: Column(
            children: [
              Image.network(Const.baseUrlImage + movieDetail?.backdropPath),
              Padding(padding: const EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star),
                      Padding(padding: const EdgeInsets.only(top: 5)),
                      Text(movieDetail?.voteAverage?.toString())
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.calendar_today),
                      Padding(padding: const EdgeInsets.only(top: 5)),
                      Text(year)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.language),
                      Padding(padding: const EdgeInsets.only(top: 5)),
                      Text(movieDetail?.originalLanguage)
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(movieDetail?.overview),
              ),
            ],
          ),
        );
      }
    }
    return Scaffold(body: widget);
  }

  void getMovieDetail(int movieId) async {
    setState(() {
      isLoading = true;
    });
    movieDetail = await movieRepository.getMovieDetail(movieId);
    setState(() {
      isLoading = false;
    });
  }
}
