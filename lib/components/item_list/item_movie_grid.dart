import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';

class ItemMovieGrid extends StatelessWidget {
  final List<Results> movies;
  final int index;

  ItemMovieGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index;
    Results movie = movies[position];
    return Padding(
      padding: _edgeInsets(position),
      child: Container(
        width: 140,
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
                Flexible(child: Text(movie?.title)),
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
      ),
    );
  }

  EdgeInsets _edgeInsets(int index) {
    int lastIndex = (movies?.length ?? 1) - 1;
    if (index == 0) {
      return EdgeInsets.fromLTRB(16, 5, 5, 10);
    } else if (index == lastIndex) {
      return EdgeInsets.fromLTRB(5, 5, 16, 10);
    } else {
      return EdgeInsets.fromLTRB(5, 5, 5, 10);
    }
  }
}
