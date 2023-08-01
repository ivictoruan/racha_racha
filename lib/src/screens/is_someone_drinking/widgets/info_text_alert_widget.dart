import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/is_someone_drinking_controller.dart';

class InfoTextAlertWidget extends StatelessWidget {
  const InfoTextAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(20), // 0.058 * size.width
      color: Colors.white,
      shadowColor: Colors.deepPurpleAccent,
      child: SizedBox(
        width: size.width * 0.85,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.004),
          child: Center(
            child: Consumer<IsSomeoneDrinkingController>(
              builder: (context, controller, child) {
                bool initialMsg =
                    controller.msgError == "Digite o valor total da conta";
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
                  child: Row(
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
                      Expanded(
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                controller.msgError,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: initialMsg == true
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 0.025 * size.width,
                                  fontWeight: FontWeight.w700,
                                ),
                                softWrap: true, // Habilita quebra de linha
                                maxLines: 2, // Define o número máximo de linhas
                                overflow: TextOverflow
                                    .ellipsis, // Define o comportamento em caso de overflow
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
