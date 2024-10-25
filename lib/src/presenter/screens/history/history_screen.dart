import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/check/entities/check_model.dart';
import '../../../external/services/firebase_check_database_service.dart';

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

  // TODO: levar isso para um controller
  Future<List<CheckModel>> _fetchChecks() async {
    final checkService = FirebaseCheckDatabaseService();
    return await checkService.getAllChecks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CheckModel>>(
        future: _checksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os checks: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Faça sua primeira divisão!'),
            );
          }

          final checks = snapshot.data!.toList();

          return ListView.builder(
            itemCount: checks.length,
            itemBuilder: (context, index) {
              final check = checks[index];

              // TODO: melhorar este ListTile (componentizar)
              return ListTile(
                title: Text('Check ${index + 1}: ${check.creationDate}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total: R\$ ${check.totalValue.toStringAsFixed(2)}'),
                    Text(
                        'Preço Individual: R\$ ${check.individualPrice.toStringAsFixed(2)}'),
                    Text(
                        'Porcentagem do Garçom: ${check.waiterPercentage.toStringAsFixed(2)}%'),
                    Text(
                        'Total do Garçom: R\$ ${check.totalWaiterValue.toStringAsFixed(2)}'),
                    Text(
                        'Alguém Bebendo: ${check.isSomeoneDrinking ? "Sim" : "Não"}'),
                    Text(
                        'Total de Bebidas: R\$ ${check.totalDrinkPrice.toStringAsFixed(2)}'),
                    Text(
                        'Total de Pessoas Bebendo: ${check.totalPeopleDrinking}'),
                    Text(
                        'Preço Individual Bebendo: R\$ ${check.individualPriceWhoIsDrinking.toStringAsFixed(2)}'),
                    Text('Total de Pessoas: ${check.totalPeople}'),
                    Text(
                        'Dia da Criação: ${check.creationDate!.day.toString()}/${check.creationDate!.month.toString()}/${check.creationDate!.year.toString()} às ${check.creationDate!.hour.toString()}:${check.creationDate!.minute.toString()}'),
                  ],
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/totalValue');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
