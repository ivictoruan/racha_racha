import 'package:flutter/material.dart';

import '../../../shared/routes/app_route_manager.dart';

class BottomNavBarWidget extends StatefulWidget {
  final bool isFinishingCheck;
  const BottomNavBarWidget({
    Key? key,
    this.isFinishingCheck = true,
  }) : super(key: key);

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  void onHistoryPressed() async {
    if (widget.isFinishingCheck) {
      final navigator = Navigator.of(context);

      // await context.read<CheckController>().restartCheck();

      if (mounted) {
        navigator.pushNamedAndRemoveUntil(
          AppRouteManager.history,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    if (!widget.isFinishingCheck) {
      selectedIndex = 0;
    }
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: (int index) async {
        switch (index) {
          case 0:
            {
              onHistoryPressed();
              break;
            }

          case 1:
            {
              if (!widget.isFinishingCheck) {
                Navigator.of(context).pushNamed(AppRouteManager.settings);
              }
              break;
            }

          case 2:
            {
              Navigator.of(context).pushNamed(AppRouteManager.settings);
              break;
            }
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.history, size: 32),
          label: "Divisões",
        ),
        if (widget.isFinishingCheck)
          BottomNavigationBarItem(
            icon: Icon(widget.isFinishingCheck ? Icons.receipt : Icons.abc),
            label: widget.isFinishingCheck
                ? "Resultado ${!widget.isFinishingCheck ? "Final" : ''}"
                : "Rachar",
          ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded, size: 32),
          label: "Menu",
        ),
      ],
      unselectedFontSize: 18,
      unselectedItemColor: Colors.deepPurple,
      selectedItemColor: Colors.deepPurple,
      selectedFontSize: 16,
    );
  }
}
