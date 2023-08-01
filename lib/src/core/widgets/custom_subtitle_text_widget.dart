import 'package:flutter/material.dart';

class CustomSubtitleTextWidget extends StatelessWidget {
  final String subtitle;
  const CustomSubtitleTextWidget({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05 * size.width,
        vertical: 0.01 * size.width,
      ),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 0.04 * size.width,
          color: Colors.deepPurple.withOpacity(0.6),
        ),
      ),
    );
  }
}
