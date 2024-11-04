import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/check_controller.dart';
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
            if (widget.isFinishingCheck) {
              await context.read<CheckController>().restartCheck();
              if (mounted) {
                Navigator.of(context).pushNamed(
                  AppRouteManager.history,
                  arguments: true,
                );
              }
            }

            break;
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: "Menu",
        ),
        
        if (widget.isFinishingCheck)
          BottomNavigationBarItem(
            icon: Icon(widget.isFinishingCheck ? Icons.receipt : Icons.abc),
            label: widget.isFinishingCheck
                ? "Resultado ${!widget.isFinishingCheck ? "Final" : ''}"
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