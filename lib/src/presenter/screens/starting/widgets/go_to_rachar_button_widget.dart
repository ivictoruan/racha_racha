import 'package:flutter/material.dart';

class GoToRacharButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  const GoToRacharButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(14),
        shadowColor: Colors.deepPurple,
        color: Colors.deepPurple[100],
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white,
          ),
          label: const Text(
            "Rachar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      );
}
