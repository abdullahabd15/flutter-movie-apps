import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/commons/app_padding.dart';
import 'package:movie_app/constants/const.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class ItemVideos extends StatelessWidget {
  final List<MovieVideo> videos;
  final int index;

  ItemVideos(this.videos, this.index);

  @override
  Widget build(BuildContext context) {
    var video = videos[index];
    return Padding(
      padding:
          AppPadding.paddingHorizontalList(index, (videos?.length ?? 1) - 1),
      child: Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildImageThumbnail(video.key),
                Icon(
                  Icons.play_arrow_sharp,
                  size: 60,
                  color: Colors.amberAccent,
                ),
              ],
            ),
            SizedBox(
              height: Dimens.default_padding,
            ),
            Text(video.name),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(String key) {
    if (key != null) {
      return SizedBox(
        child: Image.network(
          Const.generateYoutubeImageThumbnail(key),
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return AppLoading.shimmerBoxLoading(width: 250, height: 170);
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
