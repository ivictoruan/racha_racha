import '../../../domain/check/entities/check_model.dart';
import '../../../domain/check/entities/result_get_all_checks.dart';

abstract class LocalCheckDatasource {
  Future<ResultGetAllChecks> getAllChecks();
  Future<void> createCheck({required CheckModel check});
  Future<void> deleteCheck({required String checkId});
}
