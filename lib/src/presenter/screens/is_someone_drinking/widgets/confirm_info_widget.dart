import 'package:flutter/material.dart';

class ConfirmInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;

  const ConfirmInfoWidget({
    Key? key,
    required this.startText,
    required this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startText, style: style),
        Text(endText, style: style),
      ],
    );
  }
}
