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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 280,
            width: 200,
            child: Image.network(
              Const.baseUrlImage + movie?.posterPath,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 1),
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
              Flexible(child: Text(movie?.title, maxLines: 2, overflow: TextOverflow.ellipsis,)),
            ],
          )
        ],
      ),
    );
  }
}
