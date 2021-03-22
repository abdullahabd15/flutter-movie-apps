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
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: 190,
              child:
                  FittedBox(child: _buildImageMovie(movie), fit: BoxFit.fill),
            ),
            SizedBox(
              height: 3.0,
            ),
            _buildRatingMovie(movie),
            SizedBox(
              height: Dimens.default_vertical_padding,
            ),
            _buildTitleMovie(movie),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleMovie(Movie movie) {
    return Flexible(
      child: Text(
        movie?.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRatingMovie(Movie movie) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amberAccent,
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.corner_radius_20)),
          shape: BoxShape.rectangle),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 1, 16, 1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: Dimens.small_icon_size,
              color: Colors.amberAccent,
            ),
            SizedBox(
              width: Dimens.default_vertical_padding,
            ),
            Text(
              movie?.voteAverage.toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageMovie(Movie movie) {
    if (movie?.posterPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.corner_radius_20),
        child: Image.network(
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
        ),
      );
    } else {
      return Container(
        decoration:
            BoxDecoration(color: Colors.grey, shape: BoxShape.rectangle),
      );
    }
  }
}
