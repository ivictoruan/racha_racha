import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/app_assets.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/widgets/floating_action_button_widget.dart';
import '../../shared/widgets/loading_screen.dart';
import '../result/widgets/custom_bottom_nav_bar_widget.dart';
import 'controller/history_screen_controller.dart';
import 'widgets/check_item_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryScreenController>(context, listen: false)
          .fetchChecks();
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final historyController = Provider.of<HistoryScreenController>(context);

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: historyController.loading
            ? const LoadingScreen()
            : historyController.checks.isEmpty
                ? _buildEmptyWidget(context)
                : ListView.builder(
                    itemCount: historyController.checks.length,
                    itemBuilder: (context, index) {
                      final check = historyController.checks[index];
                      final checkIndex =
                          historyController.checks.length - index;
                      return CheckItemWidget(
                        check: check,
                        index: checkIndex,
                      );
                    },
                  ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () async {
            await Navigator.of(context).pushNamed(AppRouteManager.totalValue);
          },
          isEnabled: !historyController.loading,
          icon: Icons.add,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavBarWidget(
          isFinishingCheck: false,
        ),
      ),
    );
  }

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
          'Você realmente deseja sair do aplicativo?',
          style: TextStyle(
            color: Colors.deepPurple[500],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Não',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
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

  Column _buildEmptyWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              AppAssets.empty,
              height: MediaQuery.sizeOf(context).height * 0.45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Você ainda não fez nenhuma divisão! Para começar toque no botão abaixo!",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.deepPurple),
            ),
          ),
        ],
      );
}
