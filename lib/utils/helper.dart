import 'package:flutter/cupertino.dart';

class Helper {
static  double w(context) {
    return MediaQuery.of(context).size.width;
  }

  static double h(context) {
    return MediaQuery.of(context).size.height;
  }
}
