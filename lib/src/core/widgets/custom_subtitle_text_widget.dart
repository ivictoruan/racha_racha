import 'package:flutter/material.dart';

class CustomSubitleTextWidget extends StatelessWidget {
  final String subtitle;
  const CustomSubitleTextWidget({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.01 * size.width),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 0.04 * size.width,
          fontWeight: FontWeight.w400,
          color: Colors.deepPurple.withOpacity(0.6),
        ),
      ),
    );
  }
}
