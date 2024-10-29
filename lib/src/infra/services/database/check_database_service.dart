import '../../../domain/check/entities/check_model.dart';

abstract class CheckDatabaseService {
  Future<void> createCheck({required CheckModel check});
  Future<CheckModel?> getCheckById({required String checkId});
  Future<List<CheckModel>>? getAllChecks();
  Future<void> updateCheck({
    required String checkId,
    required CheckModel check,
  });
  Future<void> deleteCheck({required String checkId});
}
