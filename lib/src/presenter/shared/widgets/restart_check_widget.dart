import 'package:flutter/material.dart';

class RestartCheckWidget extends StatelessWidget {
  final void Function()? onPressed;
  const RestartCheckWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.restart_alt_rounded,
          size: 16,
          color: Colors.grey,
        ),
        label: const Text(
          "Reiniciar",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );
}
