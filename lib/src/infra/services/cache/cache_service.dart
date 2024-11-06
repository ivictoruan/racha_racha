abstract class CacheService {
  Future<void> saveData<T>(String key, T value);
  Future<T?> getData<T>(String key);
  Future<void> removeData(String key);
  Future<void> clearCache();
}
