import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check_model.dart';
import '../../../../infra/services/database/check_database_service.dart';

class HistoryController with ChangeNotifier {
  final CheckDatabaseService checkService;

  HistoryController({required this.checkService});

  bool _loading = false;
  bool get loading => _loading;

  Future<List<CheckModel>> fetchChecks() async {
    _loading = true;
    notifyListeners();
    try {
      final checks = await checkService.getAllChecks();
      return Future.value(checks);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
