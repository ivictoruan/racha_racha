import 'package:flutter/material.dart';

import '../../../shared/utils/custom_utils.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        CustomUtils customUtils = CustomUtils();

        switch (index) {
          case 0:
            customUtils.goTo("/settings", context);
            break;
          case 2:
            customUtils.goTo("/history", context);

            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: "Menu",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: "Resultado",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Histórico",
        ),
      ],
    );
  }
}
