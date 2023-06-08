import 'package:flutter/material.dart';

class CustomSmallDividerWidget extends StatelessWidget {
  const CustomSmallDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(
        height: 0,
        color: Colors.deepPurple,
      );
}
