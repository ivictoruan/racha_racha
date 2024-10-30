import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check_model.dart';
import '../../../../infra/services/database/check_database_service.dart';

class HistoryScreenController with ChangeNotifier {
  final CheckDatabaseService checkService;

  HistoryScreenController({required this.checkService});

  bool _loading = false;
  bool get loading => _loading;

  List<CheckModel> _checks = [];
  List<CheckModel> get checks => _checks;

  Future<void> fetchChecks() async {
    _loading = true;
    notifyListeners();
    try {
      _checks = await checkService.getAllChecks()!;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> reloadChecks() async {
    await fetchChecks();
  }
}
