import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/check/entities/check_model.dart';
import '../../../external/services/firebase_check_database_service.dart';
import '../../shared/widgets/floating_action_button_widget.dart';
import '../../shared/widgets/loading_screen.dart';
import '../result/widgets/custom_bottom_nav_bar_widget.dart';
import 'widgets/check_item_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<CheckModel>> _checksFuture;

  @override
  void initState() {
    super.initState();
    _checksFuture = _fetchChecks();
  }

  Future<List<CheckModel>> _fetchChecks() async {
    final checkService = FirebaseCheckDatabaseService();
    return await checkService.getAllChecks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: FutureBuilder<List<CheckModel>>(
          future: _checksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Erro ao carregar os checks: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildEmptyWidget(context);
            }

            final checks = snapshot.data!.toList();

            return ListView.builder(
              itemCount: checks.length,
              itemBuilder: (context, index) {
                final check = checks[index];
                final checkIndex = checks.length - index;
                return CheckItemWidget(
                  check: check,
                  index: checkIndex,
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () => context.go('/totalValue'),
          // TODO: desativar o botão quando estiver em loading
          isActivated: true,
          icon: Icons.add,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavBarWidget(
          isFinishingCheck: false,
        ),
      );

  Column _buildEmptyWidget(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/empty.json',
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
