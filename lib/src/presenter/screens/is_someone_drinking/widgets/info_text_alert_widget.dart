import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';

class InfoTextAlertWidget extends StatelessWidget {
  const InfoTextAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      // TODO: remover dependencia do controlador aqui
      child: Consumer<CheckController>(
        builder: (_, CheckController controller, __) {
          bool initialMsg =
              controller.msgError == "Digite o valor total da conta";
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: initialMsg == true ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(
                width: SpaceConstants.extraSmall,
              ),
              Text(
                controller.msgError,
                style: TextStyle(
                  color: initialMsg == true ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
