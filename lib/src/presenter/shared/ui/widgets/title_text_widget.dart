import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String titleText;
  const TitleTextWidget({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        titleText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple,
        ),
      );
}
