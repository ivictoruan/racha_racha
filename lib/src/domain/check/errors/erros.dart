abstract class Failure implements Exception {
  final String message;

  Failure({required this.message});
}

class LocalDatasouceError implements Failure {
  @override
  final String message;

  LocalDatasouceError({required this.message});
}

class CheckSharingServiceError implements Failure {
  @override
  final String message;

  CheckSharingServiceError({required this.message});
}
