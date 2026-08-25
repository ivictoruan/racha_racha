import '../../../domain/check/entities/check.dart';

abstract class LocalCheckDatasource {
  Future<List<Check>> getAllChecks();
  Future<String> createCheck({required Check check});
  Future<void> deleteCheck({required Check check});
}
