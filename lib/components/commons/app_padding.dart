import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class AppPadding {
  static EdgeInsets paddingHorizontalList(int index, int lastIndex) {
    if (index == 0) {
      return EdgeInsets.only(
          left: Dimens.default_horizontal_padding,
          right: Dimens.side_item_padding);
    } else if (index == lastIndex) {
      return EdgeInsets.only(
          left: Dimens.side_item_padding,
          right: Dimens.default_horizontal_padding);
    } else {
      return EdgeInsets.symmetric(
          horizontal: Dimens.side_item_padding);
    }
  }
}
