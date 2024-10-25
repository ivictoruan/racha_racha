import '../../../domain/check/entities/check_model.dart';

abstract class CheckDatabaseService {
  Future<void> createCheck(CheckModel check);
  Future<CheckModel?> getCheckById(String checkId);
  Future<List<CheckModel?>> getAllChecks();
  Future<void> updateCheck(String checkId, CheckModel check);
  Future<void> deleteCheck(String checkId);
}
