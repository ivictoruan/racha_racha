import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:racha_racha/src/domain/check/usecases/delete_check.dart';

import '../../../../domain/check/entities/check.dart';
import '../../../../domain/check/usecases/share_check.dart';
import '../../../../domain/check/usecases/get_all_checks.dart';

class HistoryScreenController with ChangeNotifier {
  final GetAllChecks _getAllChecks;
  final ShareCheck _shareCheck;
  final DeleteCheck _deleteCheck;

  HistoryScreenController({
    required GetAllChecks getAllChecks,
    required ShareCheck shareCheck,
    required DeleteCheck deleteCheck,
  })  : _shareCheck = shareCheck,
        _getAllChecks = getAllChecks,
        _deleteCheck = deleteCheck;

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

  Future<bool> delete(Check check) async {
    final result = await _deleteCheck.call(check: check);

    await fetchChecks();

    if (result.isLeft()) {
      return false;
    } else {
      return true;
    }
  }
}
