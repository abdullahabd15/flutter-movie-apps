import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class ItemAllMovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final int index;

  ItemAllMovieGrid(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    int position = index;
    Movie movie = movies[position];
    return Padding(
      padding: const EdgeInsets.all(Dimens.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImagePoster(movie),
          SizedBox(
            height: 3.0,
          ),
          _buildRatingMovie(movie),
          SizedBox(
            height: 3.0,
          ),
          _buildTitleMovie(movie),
        ],
      ),
    );
  }

  Widget _buildTitleMovie(Movie movie) {
    return Flexible(
      child: Text(movie?.title, maxLines: 2, overflow: TextOverflow.ellipsis),
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
              width: Dimens.default_padding,
            ),
            Text(movie?.voteAverage.toString())
          ],
        ),
      ),
    );
  }

  Widget _buildImagePoster(Movie movie) {
    return SizedBox(
      height: 280,
      child: movie?.posterPath == null
          ? _buildImagePlaceHolder()
          : ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.default_corner_radius),
              child: Image.network(
                Const.baseUrlImage + movie?.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return AppLoading.shimmerBoxLoading();
                },
              ),
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
}
