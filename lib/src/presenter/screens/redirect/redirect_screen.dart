import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../external/services/firebase_check_database_service.dart';

class RedirectScreen extends StatefulWidget {
  const RedirectScreen({super.key});

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  @override
  void initState() {
    super.initState();
    _checkForChecks();
  }

  Future<void> _checkForChecks() async {
    final checkService = FirebaseCheckDatabaseService();
    final checks = await checkService.getAllChecks();

    if (checks.isNotEmpty) {
      // Se houver Checks, redirecione para a tela inicial
      if (mounted) {
        context.go('/history');
      }
    } else {
      // Caso contrário, redirecione para uma tela que você desejar
      // Aqui você pode adicionar a lógica para redirecionar para outra tela
      if (mounted) {
        context
            .go('/totalValue'); // Exemplo de rota para uma tela de "sem checks"
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
