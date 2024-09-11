import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

class InfoTextAlertWidget extends StatelessWidget {
  const InfoTextAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(20), // 0.058 * size.width
      color: Colors.white,
      shadowColor: Colors.deepPurpleAccent,
      child: SizedBox(
        width: size.width * 0.85,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.004),
          child: Consumer<CheckControllerImpl>(
            builder: (context, controller, child) {
              bool initialMsg =
                  controller.msgError == "Digite o valor total da conta";
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    color: initialMsg == true ? Colors.green : Colors.red,
                    size: 0.035 * size.width,
                  ),
                  SizedBox(
                    width: 0.015 * size.width,
                  ),
                  Text(
                    controller.msgError,
                    style: TextStyle(
                      color: initialMsg == true ? Colors.green : Colors.red,
                      fontSize: 0.025 * size.width,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
