import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/check_controller.dart';
import '../utils/custom_utils.dart';

class WrongTotalCheckValueWidget extends StatelessWidget {
  final String? text;
  const WrongTotalCheckValueWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckController>(
      builder: (context, controller, child) {
        CustomUtils customUtils = CustomUtils();
        return TextButton(
          onPressed: () {
            customUtils.goTo('/totalValue', context);
          },
          child: Text(
            text ?? "Errou o valor total da conta?",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }
}
