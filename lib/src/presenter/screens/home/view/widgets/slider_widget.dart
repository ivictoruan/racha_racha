import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/controllers/check_controller.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckController>(
      builder: (context, controller, child) {
        Size size = MediaQuery.sizeOf(context);
        log('Size: ${(0.05 * size.width)}');
        return Material(
          elevation: 10,
          shadowColor: Colors.deepPurple.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: controller.check.waiterPercentage.toDouble(),
                  onChanged: (newWaiterPercentage) {
                    controller.waiterPercentage = newWaiterPercentage;
                  },
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: controller.waiterPercentage.toStringAsFixed(0),
                ),
              ),
              Text(
                "${controller.waiterPercentage.toStringAsFixed(0)} %  ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
