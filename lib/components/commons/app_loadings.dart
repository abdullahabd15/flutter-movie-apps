import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/resources/dimens/dimens.dart';
import 'package:shimmer/shimmer.dart';

class AppLoading {
  static Widget spinkitCircleLoading() {
    return SpinKitCircle(
      color: Colors.amberAccent,
      size: Dimens.large_icon_size,
    );
  }

  static Widget shimmerBoxLoading() {
    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(
        width: 400.0,
        height: 400.0,
        child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey[400],
            direction: ShimmerDirection.ltr,
            child: Card(
              color: Colors.grey,
            )
        )
      ),
    );
  }
}