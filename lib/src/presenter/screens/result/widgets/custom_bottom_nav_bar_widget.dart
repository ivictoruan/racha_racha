import 'package:flutter/material.dart';

import '../../../shared/utils/custom_utils.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();
    int selectedIndex = 1;
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            customUtils.goTo("/settings", context);
            break;
          case 2:
            _showModalRestartCheck(context, CustomUtils());
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.menu_rounded), label: "Menu"),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Resultado"),
        BottomNavigationBarItem(
            icon: Icon(Icons.restart_alt_rounded), label: "Recomeçar"),
      ],
    );
  }

  Future<void> _showModalRestartCheck(
      BuildContext context, CustomUtils customUtils) async {
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Gostaria de recomeçar?",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "Se você não quer reiniciar toque em \"Não\"",
              style: TextStyle(
                color: Colors.deepPurple[200],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    customUtils.goTo("/totalValue", context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Sim'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
