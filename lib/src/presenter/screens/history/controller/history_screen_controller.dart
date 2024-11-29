import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check.dart';
import '../../../../domain/check/usecases/get_all_checks.dart';

class HistoryScreenController with ChangeNotifier {
  final GetAllChecks getAllChecks;

  HistoryScreenController({
    required this.getAllChecks,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Check> _checks = [];
  List<Check> get checks => _checks;

  Future<void> fetchChecks() async {
    _isLoading = true;
    notifyListeners();

    final result = await getAllChecks.call();

    result.fold(
      (failure) {
        log(failure.message.toString());
      },
      (sucess) {
        _checks = sucess;
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> reloadChecks() async {
    await fetchChecks();
  }
}
