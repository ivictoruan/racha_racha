import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/check_controller.dart';
import '../utils/custom_utils.dart';

class CustomWillPopWidget extends StatelessWidget {
  final Widget body;
  final bool? isExitedPaged;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool? isBodyScrollable;

  const CustomWillPopWidget({
    Key? key,
    required this.body,
    this.isExitedPaged,
    this.floatingActionButton,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.isBodyScrollable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          barrierColor: Colors.deepPurple.withOpacity(0.2),
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  isExitedPaged ?? false
                      ? "Gostaria de sair do app?"
                      : 'Gostaria de recomeçar?',
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.058 * size.width),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Consumer<CheckController>(
                  builder: (context, controller, child) {
                    return TextButton(
                      onPressed: () {
                        final CustomUtils customUtils = CustomUtils();
                        isExitedPaged ?? false
                            ? customUtils.exitApp()
                            : controller.restartSplit();
                        customUtils.goTo("/totalValue", context);
                      },
                      child: const Text('Sim'),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Não'),
                ),
              ],
            );
          },
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: SingleChildScrollView(
              physics: isBodyScrollable == false
                  ? const NeverScrollableScrollPhysics()
                  : null,
              child: body,
            ),
          ),
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
