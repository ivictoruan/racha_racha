import 'package:flutter/material.dart';

import '../../../shared/utils/custom_utils.dart';

class GoToRacharButtonWidget extends StatefulWidget {
  const GoToRacharButtonWidget({super.key});

  @override
  State<GoToRacharButtonWidget> createState() => _GoToRacharButtonWidgetState();
}

class _GoToRacharButtonWidgetState extends State<GoToRacharButtonWidget> {
  CustomUtils get customUtils => CustomUtils();

  void get onPressed => customUtils.goTo(
        "/history",
        context,
      );

  @override
  Widget build(BuildContext context) => Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(14),
        shadowColor: Colors.deepPurple,
        color: Colors.deepPurple[100],
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          onPressed: () => onPressed,
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
