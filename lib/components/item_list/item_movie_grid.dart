import 'package:flutter/material.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:shimmer/shimmer.dart';

class ItemMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final int index;

  ItemMovieGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index;
    Movie movie = movies[position];
    return Padding(
      padding: _edgeInsets(position),
      child: Container(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: 190,
              child: _imageMovies(movie)
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
                  shape: BoxShape.rectangle
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 16, 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(movie?.voteAverage.toString())
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Flexible(
                    child: Text(
                  movie?.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _imageMovies(Movie movie) {
    if (movie?.posterPath != null) {
      return Image.network(
        Const.baseUrlImage + movie?.posterPath,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return _imageShimmer();
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
          return Container(
            height: 220,
            width: 190,
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle
            ),
          );
        },
      );
    } else {
      return Container(
        height: 220,
        width: 190,
        decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.rectangle
        ),
      );
    }
  }

  Widget _imageShimmer() {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey[400],
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.rectangle
          ),
        )
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
