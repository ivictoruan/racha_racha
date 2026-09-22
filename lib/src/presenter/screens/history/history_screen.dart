import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../domain/check/entities/check.dart';
import '../../../infra/services/cache/cache_service.dart';
import '../../shared/constants/app_assets.dart';
import '../../shared/constants/cache_keys.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/ui/widgets/floating_action_button_widget.dart';
import '../../shared/ui/widgets/loading_screen.dart';
import '../result/widgets/bottom_nav_bar_widget.dart';
import 'controller/history_screen_controller.dart';
import 'widgets/popups/want_exit_popup_widget.dart';
import 'widgets/check_item_widget.dart';

class HistoryScreenWrapper extends StatelessWidget {
  const HistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) => ShowCaseWidget(
        autoPlay: true,
        autoPlayDelay: const Duration(seconds: 3),
        onFinish: () async => await onFinish(context),
        builder: (context) => _HistoryScreenTutorial(),
        // ),
      );

  Future<void> onFinish(BuildContext context) async {
    final navigator = Navigator.of(context);

    await Future.delayed(const Duration(milliseconds: 500));

    navigator.pushNamed(AppRouteManager.splitScreen);
  }
}

class _HistoryScreenTutorial extends StatefulWidget {
  @override
  State<_HistoryScreenTutorial> createState() => _HistoryScreenTutorialState();
}

class _HistoryScreenTutorialState extends State<_HistoryScreenTutorial> {
  final GlobalKey _addButtonShowcaseKey = GlobalKey();
  final GlobalKey _titleShowcaseKey = GlobalKey();
  final GlobalKey _emptyStateShowcaseKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _checkFirstTime(),
    );
  }

  Future<void> _checkFirstTime() async {
    final cache = context.read<CacheService>();
    final hasSeenTutorial =
        await cache.getData<bool>(CacheKeys.hasSeenHistoryTutorial) ?? false;

    if (!hasSeenTutorial) {
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([
          _titleShowcaseKey,
          _emptyStateShowcaseKey,
          _addButtonShowcaseKey,
        ]);
        await cache.saveData<bool>(
          CacheKeys.hasSeenHistoryTutorial,
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => _HistoryScreen(
        addButtonKey: _addButtonShowcaseKey,
        titleKey: _titleShowcaseKey,
        emptyStateKey: _emptyStateShowcaseKey,
      );
}

class _HistoryScreen extends StatefulWidget {
  final GlobalKey? addButtonKey;
  final GlobalKey? titleKey;
  final GlobalKey? emptyStateKey;

  const _HistoryScreen({
    Key? key,
    this.addButtonKey,
    this.titleKey,
    this.emptyStateKey,
  }) : super(key: key);

  @override
  State<_HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<_HistoryScreen> {
  void fetchChecks() => WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await Provider.of<HistoryScreenController>(context, listen: false)
              .fetchChecks();
        },
      );

  @override
  void initState() {
    super.initState();
    fetchChecks();
  }

  @override
  Widget build(BuildContext context) {
    final historyController = Provider.of<HistoryScreenController>(context);

    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Showcase(
            key: widget.titleKey ?? GlobalKey(),
            description: 'Aqui você encontra todas as suas divisões de conta',
            child: Text(
              'Histórico',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          elevation: 4,
          shadowColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        body: historyController.isLoading
            ? const LoadingScreen()
            : historyController.checks.isEmpty
                ? _buildEmptyWidget(context)
                : ListenableBuilder(
                    listenable: historyController,
                    builder: (context, child) => ListView.builder(
                      itemCount: historyController.checks.length,
                      itemBuilder: (context, index) {
                        final Check check = historyController.checks[index];
                        final checkIndex =
                            historyController.checks.length - index;
                        return CheckItemWidget(
                          check: check,
                          index: checkIndex,
                        );
                      },
                    ),
                  ),
        // TODO: fazer um wrapper para a parte do ShowCase FABWrapper()
        floatingActionButton: Showcase(
          key: widget.addButtonKey ?? GlobalKey(),
          description: 'Toque aqui para adicionar uma nova divisão de conta',
          tooltipBackgroundColor: Colors.deepPurple,
          descTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          targetShapeBorder: const CircleBorder(),
          child: FloatingActionButtonWidget(
            onPressed: () async {
              final result = await Navigator.of(context).pushNamed(
                AppRouteManager.splitScreen,
              );
              if (result == true) {
                fetchChecks();
              }
            },
            isEnabled: !historyController.isLoading,
            icon: Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const BottomNavBarWidget(
          isFinishingCheck: false,
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => const WantExitPopupWidget(),
    );
    return shouldPop ?? false;
  }

  Widget _buildEmptyWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Showcase(
              key: widget.emptyStateKey ?? GlobalKey(),
              description:
                  'Quando você não tiver nenhuma divisão, esta tela aparecerá vazia',
              child: Lottie.asset(
                AppAssets.empty,
                height: MediaQuery.sizeOf(context).height * 0.45,
              ),
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
