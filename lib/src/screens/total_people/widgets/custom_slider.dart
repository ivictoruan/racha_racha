import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/total_people_controller.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TotalPeopleController>(
      builder: (context, controller, child) {
        Size size = MediaQuery.sizeOf(context);
        return Material(
          elevation: 2,
          shadowColor: Colors.deepPurple.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: controller.model.waiterPercentage.toDouble(),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 0.05 * size.width,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
