import 'package:flutter/material.dart';

class KeyboardUtils {
  KeyboardUtils.hideSoftInputKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}