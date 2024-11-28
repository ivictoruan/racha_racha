import 'package:flutter/material.dart';
import '../../../shared/ui/widgets/box_shadow_widget.dart';

class GoToRacharButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  const GoToRacharButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => BoxShadowWidget(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          onPressed: onPressed,
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white,
          ),
          label: const Text(
            "Começar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      );
}
