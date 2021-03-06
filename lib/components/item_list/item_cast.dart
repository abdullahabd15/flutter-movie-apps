import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/credit_model.dart';

class ItemCast extends StatelessWidget {
  final List<Cast> casts;
  final int position;

  ItemCast(this.casts, this.position);

  @override
  Widget build(BuildContext context) {
    Cast cast = casts?.elementAt(position);
    if (cast != null) {
      return Padding(
        padding: _edgeInsets(position),
        child: Container(
          width: 100,
          child: Column(
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: SizedBox(
                      height: 140,
                      child: _imageCast(cast))),
              SizedBox(height: 3),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Text(
                      "(${cast.character})",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      cast.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _imageCast(Cast cast) {
    if (cast?.profilePath != null) {
      return Image.network(
        Const.baseUrlImage + cast?.profilePath,
        fit: BoxFit.contain,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SpinKitCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          );
        },
      );
    } else {
      return _imagePlaceHolder();
    }
  }

  Widget _imagePlaceHolder() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.rectangle,
      ),
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

  EdgeInsets _edgeInsets(int index) {
    int lastIndex = (casts?.length ?? 1) - 1;
    if (index == 0) {
      return EdgeInsets.fromLTRB(16, 5, 5, 10);
    } else if (index == lastIndex) {
      return EdgeInsets.fromLTRB(5, 5, 16, 10);
    } else {
      return EdgeInsets.fromLTRB(5, 5, 5, 10);
    }
  }
}
