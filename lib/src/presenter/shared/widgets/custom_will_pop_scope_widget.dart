import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/constants/space_constants.dart';
import '../controllers/check_controller.dart';
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

  void onYesPressed(controller, context) {
    final CustomUtils customUtils = CustomUtils();
    isExitedPaged ?? false ? customUtils.exitApp() : controller.restartCheck();
    customUtils.goTo("/totalValue", context);
  }

  Color get barrierColor => Colors.deepPurple.withOpacity(0.2);

  String get text => isExitedPaged ?? false
      ? "Gostaria de sair do app?"
      : 'Gostaria de recomeçar?';
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final bool? shouldPop = await showDialog<bool>(
            context: context,
            barrierColor: barrierColor,
            builder: (_) => AlertDialog(
              title: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  SpaceConstants.extraSmall,
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Consumer<CheckControllerImpl>(
                  builder: (_, CheckControllerImpl controller, __) =>
                      TextButton(
                    onPressed: () => onYesPressed,
                    child: const Text('Sim'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Não'),
                ),
              ],
            ),
          );
          return shouldPop ?? false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar,
          drawer: drawer,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: SpaceConstants.extraSmall,
                right: SpaceConstants.extraSmall,
              ),
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
