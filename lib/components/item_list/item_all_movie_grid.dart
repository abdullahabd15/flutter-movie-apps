import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';

class ItemAllMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final int index;

  ItemAllMovieGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index;
    Movie movie = movies[position];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.network(
            Const.baseUrlImage + movie?.posterPath,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            },
          ),
          SizedBox(height: 3),
          Row(
            children: [
              Flexible(child: Text(movie?.title, maxLines: 2, overflow: TextOverflow.ellipsis,)),
            ],
          ),
          SizedBox(height: 1),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amberAccent,
              ),
              SizedBox(
                width: 5,
              ),
              Text(movie?.voteAverage.toString())
            ],
          )
        ],
      ),
    );
  }
}
