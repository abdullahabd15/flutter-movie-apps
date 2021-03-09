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
          SizedBox(
            height: 280,
            child: Image.network(
              Const.baseUrlImage + movie?.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return AppLoading.shimmerBoxLoading();
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimens.single_corner_radius)),
                shape: BoxShape.rectangle
            ),
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
                    width: Dimens.default_padding,
                  ),
                  Text(movie?.voteAverage.toString())
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.default_padding),
          Row(
            children: [
              Flexible(child: Text(movie?.title, maxLines: 2, overflow: TextOverflow.ellipsis)),
            ],
          )
        ],
      ),
    );
  }
}
