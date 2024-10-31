import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/check_controller.dart';
import '../../../shared/routes/app_route_manager.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  final bool isFinishingCheck;
  const CustomBottomNavBarWidget({
    Key? key,
    this.isFinishingCheck = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) async {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(AppRouteManager.settings);
            break;
          case 2:
            if (isFinishingCheck) {
              await context.read<CheckController>().restartCheck();
              Navigator.of(context).pushNamed(
                AppRouteManager.history,
                arguments: true,
              );
            }

            break;
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: "Menu",
        ),
        if (isFinishingCheck)
          BottomNavigationBarItem(
            icon: Icon(isFinishingCheck ? Icons.receipt : Icons.abc),
            label: isFinishingCheck
                ? "Resultado ${!isFinishingCheck ? "Final" : ''}"
                : "Rachar",
          ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Histórico",
        ),
      ],
    );
  }
}
