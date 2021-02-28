import 'package:flutter/material.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/movie_model.dart';

class ItemMovies extends StatefulWidget {
  final Results movie;

  ItemMovies(this.movie);

  @override
  _ItemMoviesState createState() => _ItemMoviesState();
}

class _ItemMoviesState extends State<ItemMovies> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        height: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(Const.baseUrlImage + widget.movie?.posterPath,
                    width: 100),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie?.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("Release Date: " + widget.movie?.releaseDate),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rating: " + widget.movie?.voteAverage?.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
