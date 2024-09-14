import 'package:flutter/material.dart';

import '../utils/custom_utils.dart';

class WrongTotalCheckValueWidget extends StatelessWidget {
  const WrongTotalCheckValueWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FilledButton.tonalIcon(
        onPressed: () => CustomUtils().goTo('/totalValue', context),
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
