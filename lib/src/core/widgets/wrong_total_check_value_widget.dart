import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/check_controller/check_controller.dart';
import '../utils/custom_utils.dart';

class WrongTotalCheckValueWidget extends StatelessWidget {
  final String? text;
  const WrongTotalCheckValueWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckController>(
      builder: (context, controller, child) {
        CustomUtils customUtils = CustomUtils();
        return FilledButton.tonalIcon(
            onPressed: () {
              customUtils.goTo('/totalValue', context);
            },
            icon: const Icon(
              Icons.restart_alt_rounded,
              size: 16,
              color: Colors.grey,
            ),
            label: Text(
              text ?? "Reiniciar",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey,
              ),
            ));
      },
    );
  }
}
