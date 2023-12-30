abstract class CheckControllerInterface {
  void calculateCheckResult();
  void calculateCheckResultWithDrinkers();
  void calculateCheckResultWithoutDrinkers();
  Future<void> restartSplit();
}
