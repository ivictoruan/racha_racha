import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/check_controller.dart';

import '../../../../domain/check/entities/check_model.dart';
import 'result_info_widget.dart';

class ResultBodyWidget extends StatelessWidget {
  const ResultBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    final double heightBetweenResultInfo = size.height * 0.02;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(0.03125 * size.height),
        child: SingleChildScrollView(
          child: Consumer<CheckControllerImpl>(
            builder: (context, controller, child) {
              CheckModel model = controller.check;
              return Column(
                children: [
                  if (model.isSomeoneDrinking) ...{
                    SizedBox(height: heightBetweenResultInfo),
                    ResultInfoWidget(
                      startText: "Se bebeu, paga:",
                      endText:
                          model.individualPriceWhoIsDrinking.toStringAsFixed(2),
                    ),
                  },
                  SizedBox(height: heightBetweenResultInfo),
                  ResultInfoWidget(
                    startText: model.isSomeoneDrinking
                        ? "Não bebeu, paga:"
                        : "Valor individual: ",
                    endText: model.individualPrice.toStringAsFixed(2),
                  ),
                  SizedBox(height: heightBetweenResultInfo),
                  if (model.waiterPercentage > 0)
                    ResultInfoWidget(
                      startText: "Valor total sem gorjeta:",
                      endText: (model.totalValue - model.totalWaiterValue)
                          .toStringAsFixed(2),
                    ),
                  SizedBox(height: heightBetweenResultInfo),
                  ResultInfoWidget(
                    startText: "Valor total:",
                    endText: model.totalValue.toStringAsFixed(2),
                  ),
                  SizedBox(height: heightBetweenResultInfo),
                  ResultInfoWidget(
                    startText: "Gorjeta:",
                    endText: model.totalWaiterValue.toStringAsFixed(2),
                  ),
                  SizedBox(height: heightBetweenResultInfo),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
