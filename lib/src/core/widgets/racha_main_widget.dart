import 'package:flutter/material.dart';

class RachaMainWidget extends StatelessWidget {
  final double widthPercentage;
  final double heightPercentage;
  const RachaMainWidget({super.key, required this.widthPercentage, required this.heightPercentage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Hero(
      tag: 'splash',
      child: Image.asset(
        "assets/images/app/splash.png",
        width: size.width * widthPercentage,
        height: size.height * heightPercentage,
      ),
    );
  }
}
