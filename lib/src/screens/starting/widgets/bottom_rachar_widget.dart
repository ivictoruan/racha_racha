
import 'package:flutter/material.dart';

import '../../../core/utils/custom_utils.dart';


class BottomRacharWidget extends StatefulWidget {
  const BottomRacharWidget({super.key});

  @override
  State<BottomRacharWidget> createState() => _BottomRacharWidgetState();
}

class _BottomRacharWidgetState extends State<BottomRacharWidget> {
  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Colors.deepPurple,
      color: Colors.deepPurple[100],
      child: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () => customUtils.goTo(
          "/totalValue",
          context,
        ),
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
}
