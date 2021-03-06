import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/commons/app_padding.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class ItemCast extends StatelessWidget {
  final List<Cast> casts;
  final int position;

  ItemCast(this.casts, this.position);

  @override
  Widget build(BuildContext context) {
    Cast cast = casts?.elementAt(position);
    if (cast != null) {
      return Padding(
        padding: AppPadding.paddingHorizontalList(
            position, (casts?.length ?? 1) - 1),
        child: Container(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 140,
                child: _buildImageCast(cast),
              ),
              SizedBox(
                height: Dimens.default_vertical_padding,
              ),
              _buildName(cast),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildName(Cast cast) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimens.default_vertical_padding,
          ),
          Text(
            "(${cast.character})",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Dimens.small_font_size),
          ),
          SizedBox(
            height: Dimens.default_vertical_padding,
          ),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Dimens.normal_font_size),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCast(Cast cast) {
    if (cast?.profilePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.default_corner_radius),
        child: Image.network(Const.baseUrlImage + cast?.profilePath,
            fit: BoxFit.contain, loadingBuilder: (BuildContext context,
                Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return AppLoading.shimmerBoxLoading(
            width: 160,
            height: 240,
          );
        }),
      );
    } else {
      return _buildImagePlaceHolder();
    }
  }

  Widget _buildImagePlaceHolder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.default_corner_radius),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Container(
          height: 748,
          width: 500,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[100],
          ),
        ),
      ),
    );
  }
}
