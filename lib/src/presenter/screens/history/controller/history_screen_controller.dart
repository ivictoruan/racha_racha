import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check.dart';
import '../../../../domain/check/usecases/share_check.dart';
import '../../../../domain/check/usecases/get_all_checks.dart';

class HistoryScreenController with ChangeNotifier {
  final GetAllChecks _getAllChecks;
  final ShareCheck _shareCheck;
  // TODO: implementar caso de uso de deletar!

  HistoryScreenController({
    required GetAllChecks getAllChecks,
    required ShareCheck shareCheck,
  })  : _shareCheck = shareCheck,
        _getAllChecks = getAllChecks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Check> _checks = [];
  List<Check> get checks => _checks;

  Future<void> fetchChecks() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getAllChecks.call();

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

  Future<bool> shareCheck(Check check) async {
    final result = await _shareCheck.call(check: check);

    return result.fold(
      (failure) {
        // TODO: tratar esta falha.
        log(failure.message);
        return false;
      },
      (sucess) {
        return sucess;
      },
    );
  }
}
