import 'package:flutter/material.dart';

class CustomTitleTextWidget extends StatelessWidget {
  final String titleText;
  const CustomTitleTextWidget({Key? key, required this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Text(
      titleText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 0.063 * size.width,
        fontWeight: FontWeight.w700,
        color: Colors.purple,
      ),
    );
  }
}
