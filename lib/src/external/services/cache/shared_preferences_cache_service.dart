import 'package:shared_preferences/shared_preferences.dart';

import '../../../infra/services/cache/cache_service.dart';

class SharedPreferencesCacheService extends CacheService {
  late final SharedPreferences _prefs;

  SharedPreferencesCacheService() {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData<T>(String key, T value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError("Type ${T.runtimeType} is not supported");
    }
  }

  @override
  Future<T?> getData<T>(String key) async {
    if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T?;
    } else {
      throw UnsupportedError("Type ${T.runtimeType} is not supported");
    }
  }

  @override
  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clearCache() async {
    await _prefs.clear();
  }
}
