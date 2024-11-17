import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../infra/services/cache/cache_service.dart';
import '../../shared/constants/app_assets.dart';
import '../../shared/constants/cache_keys.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/widgets/floating_action_button_widget.dart';
import '../../shared/widgets/loading_screen.dart';
import '../result/widgets/bottom_nav_bar_widget.dart';
import 'controller/history_screen_controller.dart';
import 'widgets/check_item_widget.dart';

class HistoryScreenWrapper extends StatelessWidget {
  const HistoryScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      autoPlay: true,
      autoPlayDelay: const Duration(seconds: 3),
      onStart: (a, b) {
        log('starting');
      },

      onFinish: () async {
        final navigator = Navigator.of(context);
        await Future.delayed(
          const Duration(milliseconds: 500),
        );
        navigator.pushNamed(AppRouteManager.totalValue);
      },
      builder: (context) => _HistoryScreenTutorial(),
      // ),
    );
  }
}

class _HistoryScreenTutorial extends StatefulWidget {
  @override
  State<_HistoryScreenTutorial> createState() => _HistoryScreenTutorialState();
}

class _HistoryScreenTutorialState extends State<_HistoryScreenTutorial> {
  // Chaves para cada elemento do tutorial
  final GlobalKey _addButtonShowcaseKey = GlobalKey();
  final GlobalKey _titleShowcaseKey = GlobalKey();
  final GlobalKey _emptyStateShowcaseKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkFirstTime());
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
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Showcase(
            key: widget.titleKey ?? GlobalKey(),
            description: 'Aqui você encontra todas as suas divisões de conta',
            child: Text(
              'Histórico',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.deepPurple[600],
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: historyController.isLoading
            ? const LoadingScreen()
            : historyController.checks.isEmpty
                ? _buildEmptyWidget(context)
                : ListenableBuilder(
                    listenable: historyController,
                    builder: (context, child) => ListView.builder(
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
                  ),
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
            onPressed: () => Navigator.of(context).pushNamed(
              AppRouteManager.totalValue,
            ),
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
