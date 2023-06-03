import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.black,
          size: 50.0,
          duration: Duration(seconds: 2)
        ),
      ),
    );
  }
}
