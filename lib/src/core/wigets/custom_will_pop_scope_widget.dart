import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/check_controller.dart';
import '../utils/custom_utils.dart';

class CustomWillPopWidget extends StatelessWidget {
  final Widget child;
  const CustomWillPopWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          barrierColor: Colors.purple.withOpacity(0.1),
          builder: (context) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'Gostaria de recomeçar?',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.058 * size.width),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Consumer<CheckController>(
                  builder: (context, controller, child) {
                    return TextButton(
                      onPressed: () {
                        CustomUtils customUtils = CustomUtils();
                        controller.restartSplit();
                        customUtils.goTo("/totalValue", context);
                      },
                      child: const Text('Sim'),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Não'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: child,
    );
  }
}
