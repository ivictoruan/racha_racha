import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controller/check_controller.dart';
import '../../../core/models/check_model.dart';

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
          child: Consumer<CheckController>(
            builder: (context, controller, child) {
              CheckModel model = controller.model;
              return Column(
                children: [
                  if (model.isSomeoneDrinking) ...{
                    SizedBox(height: heightBetweenResultInfo),
                    ResultInfoWidget(
                      startText: "Se bebeu, paga:",
                      endText:
                          model.individualPriceWhoIsDrinking.toStringAsFixed(2),
                      // isMainResult: true,
                    ),
                  },
                  SizedBox(height: heightBetweenResultInfo),
                  ResultInfoWidget(
                    startText: model.isSomeoneDrinking
                        ? "Não bebeu, paga:"
                        : "Valor individual: ",
                    endText: model.individualPrice.toStringAsFixed(2),
                    // isMainResult: true,
                  ),
                  SizedBox(height: heightBetweenResultInfo),
                  if (model.waiterPercentage > 0)
                    ResultInfoWidget(
                      startText: "Valor total sem gorjeta:",
                      endText: (model.totalCheckPrice - model.totalWaiterValue)
                          .toStringAsFixed(2),
                      // isMainResult: true,
                    ),
                  SizedBox(height: heightBetweenResultInfo),
                  ResultInfoWidget(
                    startText: "Valor total:",
                    endText: model.totalCheckPrice.toStringAsFixed(2),
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
