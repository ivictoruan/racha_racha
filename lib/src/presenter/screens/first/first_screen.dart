import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../infra/services/database/auth_service.dart';
import '../../../infra/services/cache/cache_service.dart';
import '../../shared/constants/cache_keys.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/controllers/user_controller.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
    final userId = await cacheService.getData<String>(CacheKeys.userId);

    if (userId == null || userId.isEmpty) {
      userController.id = await authService.signInAnonymously();
      await cacheService.saveData<String>(
        CacheKeys.userId,
        userController.id,
      );
    } else {
      userController.id = userId;
    }
  }

  Future<void> _handleAppStart({required CacheService cacheService}) async {
    final alreadyStarted =
        await cacheService.getData<bool>(CacheKeys.alreadyStartsApp) ?? false;

    if (!alreadyStarted) {
      await cacheService.saveData<bool>(
        CacheKeys.alreadyStartsApp,
        true,
      );
      _navigateToStarting();
      return;
    }

    _navigateToHistory();
  }

  void _navigateToStarting() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouteManager.starting);
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

    _initializeUserSession();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
