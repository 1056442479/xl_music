
 import 'dart:io';

import 'package:flutter/material.dart';

class CusBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    // ignore: deprecated_member_use
    return super.buildViewportChrome(context, child, axisDirection);
  }
}
