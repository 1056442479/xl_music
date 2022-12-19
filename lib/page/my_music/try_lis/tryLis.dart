
import 'package:flutter/material.dart';

class TryLisPage extends StatelessWidget {
  const TryLisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Color.fromRGBO(30, 30, 31, 1),
      child: Center(
        child: Text("暂不开发",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
