import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/space_constants.dart';

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
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Deseja sair?',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Você realmente deseja sair da tela?',
          style: TextStyle(
            color: Colors.deepPurple[500],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text(
              'Não',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () => onYesPressed(),
            child: const Text(
              'Sim',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
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
