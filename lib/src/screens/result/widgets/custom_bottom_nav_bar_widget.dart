import 'package:flutter/material.dart';

import '../../../core/utils/custom_utils.dart';

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
            _showModalRestartSplit(context, CustomUtils());
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

  Future<void> _showModalRestartSplit(
      BuildContext context, CustomUtils customUtils) async {
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding:
            const EdgeInsets.all(24), // Increase padding for better spacing
        height: size.height * 0.3, // Increase the height of the modal
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Gostaria de recomeçar?",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18, // Increase font size for the title
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Se você não quer reiniciar toque em \"Não\"",
              style: TextStyle(
                color: Colors.deepPurple[200],
                fontSize: 14, // Increase font size for the secondary text
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    customUtils.goTo("/totalValue", context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(
                        100, 40), // Set a minimum size for the button
                  ),
                  child: const Text(
                    'Sim',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ), // Increase font size for the button text
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(
                        100, 40), // Set a minimum size for the button
                  ),
                  child: const Text(
                    'Não',
                    style: TextStyle(
                        fontSize: 14), // Increase font size for the button text
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
