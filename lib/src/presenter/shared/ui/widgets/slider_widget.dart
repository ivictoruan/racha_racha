import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final double value;
  final void Function(double)? onChanged;
  final String? label;

  const SliderWidget({
    Key? key,
    required this.value,
    this.onChanged,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: 4,
        shadowColor: Colors.deepPurple.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                onChanged: onChanged,
                min: 0,
                max: 100,
                divisions: 20,
                label: label,
              ),
            ),
            Text(
              "${value.toStringAsFixed(0)} %  ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
}
