import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/commons/app_padding.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class ItemMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final int index;

  ItemMovieGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index;
    Movie movie = movies[position];
    return Padding(
      padding:
          AppPadding.paddingHorizontalList(position, (movies?.length ?? 1) - 1),
      child: Container(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 220,
                width: 190,
                child: FittedBox(child: _imageMovies(movie), fit: BoxFit.fill)),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight:
                          Radius.circular(Dimens.single_corner_radius)),
                  shape: BoxShape.rectangle),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 3, 16, 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: Dimens.small_icon_size,
                    ),
                    SizedBox(
                      width: Dimens.default_vertical_padding,
                    ),
                    Text(movie?.voteAverage.toString())
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimens.default_vertical_padding),
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
          return AppLoading.shimmerBoxLoading();
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace stackTrace) {
          return Container(
            decoration:
                BoxDecoration(color: Colors.grey, shape: BoxShape.rectangle),
          );
        },
      );
    } else {
      return Container(
        decoration:
            BoxDecoration(color: Colors.grey, shape: BoxShape.rectangle),
      );
    }
  }
}
