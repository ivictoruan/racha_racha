import '../../../domain/check/entities/check.dart';

abstract class LocalCheckDatasource {
  Future<List<Check>> getAllChecks();
  Future<void> createCheck({required Check check});
  Future<void> deleteCheck({required Check check});
}
