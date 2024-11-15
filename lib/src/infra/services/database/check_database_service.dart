import '../../../domain/check/entities/check_model.dart';

// TODO: alterar para repository
abstract class CheckDatabaseService {
  Future<void> createCheck({required CheckModel check});

  Future<List<CheckModel>>? getAllChecks();

  // Future<CheckModel?> getCheckById({required String checkId});

  // Future<void> updateCheck({
  //   required String checkId,
  //   required CheckModel check,
  // });

  Future<void> deleteCheck({required String checkId});
}
