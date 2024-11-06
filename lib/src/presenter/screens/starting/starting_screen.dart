import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/infra/services/cache/cache_service.dart';
import 'package:racha_racha/src/presenter/shared/routes/app_route_manager.dart';

import '../../../infra/services/database/auth_service.dart';
import '../../shared/constants/app_assets.dart';
import '../../shared/controllers/user_controller.dart';
import '../../shared/widgets/will_pop_scope_widget.dart';
import '../../shared/constants/space_constants.dart';
import 'widgets/go_to_rachar_button_widget.dart';
import 'widgets/introduction_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  void _initializeUserSession() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final userController = context.read<UserController>();
      final authService = context.read<AuthService>();
      final cacheService = context.read<CacheService>();

      await _setUserId(
        userController: userController,
        authService: authService,
        cacheService: cacheService,
      );

      await _handleAppStart(cacheService: cacheService);
    });
  }

  Future<void> _setUserId({
    required UserController userController,
    required AuthService authService,
    required CacheService cacheService,
  }) async {
    final userId = await cacheService.getData<String>('userId');

    if (userId == null || userId.isEmpty) {
      userController.id = await authService.signInAnonymously();
      await cacheService.saveData<String>('userId', userController.id);
    } else {
      userController.id = userId;
    }
  }

  Future<void> _handleAppStart({required CacheService cacheService}) async {
    final alreadyStarted =
        await cacheService.getData<bool>('alreadyStartsApp') ?? false;

    if (!alreadyStarted) {
      await cacheService.saveData<bool>('alreadyStartsApp', true);
    } else {
      _navigateToHistory();
    }
  }

  void _navigateToHistory() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouteManager.history);
    }
  }

  @override
  void initState() {
    super.initState();

    /// TODO: esta inicialização deve estar em outra tela (como FirstRoute ou FirstScreen)
    /// TODO: levar essa função para essa tela e ela deve levar para a tela de histórico ou para esta te starting
    /// !FIX: está aparecendo por alguns ms na tela ao redirecionar!
    _initializeUserSession();
  }

  @override
  Widget build(BuildContext context) => WillPopScopeWidget(
        onYesPressed: () => Navigator.pop(context, true),
        appBar: buildAppBar,
        body: const IntroductionWidget(),
        isBodyScrollable: false,
        floatingActionButton: GoToRacharButtonWidget(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouteManager.history,
            (route) => false,
          ),
        ),
        mustShowDialog: false,
      );

  PreferredSizeWidget get buildAppBar => AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: SpaceConstants.large),
          child: Image.asset(
            AppAssets.splash,
            width: 240,
            height: 120,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      );
}
