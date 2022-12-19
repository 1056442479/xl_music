import 'dart:ui';

import 'package:flutter/material.dart';


class MyLoading extends Dialog {
  final String title;

  const MyLoading(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: ClipRect(
                // 可裁切的矩形
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 500.0,
                      height: 700.0,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
//
