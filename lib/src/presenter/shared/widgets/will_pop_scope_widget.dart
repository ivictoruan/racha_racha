import 'package:flutter/material.dart';

import '../constants/space_constants.dart';
import 'will_pop_scope_widget/confirm_will_pop_scope_popup_widget.dart';

class WillPopScopeWidget extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool isBodyScrollable;
  final void Function() onYesPressed;
  final bool mustShowDialog;

  const WillPopScopeWidget({
    Key? key,
    required this.body,
    required this.onYesPressed,
    this.floatingActionButton,
    this.appBar,
    this.bottomNavigationBar,
    this.drawer,
    this.isBodyScrollable = false,
    this.mustShowDialog = true,
  }) : super(key: key);

  Future<bool> onWillPop(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => ConfirmWillPopScopePopupWidget(
              onYesPressed: onYesPressed,
            ));
    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: mustShowDialog ? () => onWillPop(context) : null,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
