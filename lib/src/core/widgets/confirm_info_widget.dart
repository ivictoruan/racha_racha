
import 'package:flutter/material.dart';

class ConfirmInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;

  const ConfirmInfoWidget(
      {Key? key, required this.startText, required this.endText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startText, style: Theme.of(context).textTheme.bodyLarge),
        Text(endText, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
