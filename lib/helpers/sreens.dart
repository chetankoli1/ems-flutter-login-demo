import 'package:flutter/material.dart';

class Screens {
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isPortait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool portMode(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? true
        : false;
  }

  static double logoSize(BuildContext context) {
    if (Screens.isPortait(context)) {
      return Screens.height(context) * 1;
    }else{
      return Screens.width(context) * 1;
    }
  }
}
