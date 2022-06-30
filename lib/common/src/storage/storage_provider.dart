import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageProvider {
  Future<bool> save(String key, dynamic value);
  Future<dynamic> read(String key);
  Future<bool> delete(String key);
}

class StorageProviderImpl extends StorageProvider {
  late SharedPreferences _storage;
  @override
  Future<bool> delete(String key) async {
    _storage = await SharedPreferences.getInstance();
    return _storage.remove(key).then((bool success) => success);
  }

  @override
  Future<dynamic> read(String key) async {
    _storage = await SharedPreferences.getInstance();

    Object? storedValue = _storage.get(key);

    switch (storedValue.runtimeType) {
      case int:
        return _storage.getInt(key);
      case double:
        return _storage.getDouble(key);
      case String:
        return _storage.getString(key);
      case List<String>:
        return _storage.getStringList(key);
      case bool:
        return _storage.getBool(key);
      default:
        return _storage.getString(key);
    }
  }

  @override
  Future<bool> save(String key, dynamic value) async {
    _storage = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case int:
        return _storage.setInt(key, value).then((bool success) => success);
      case double:
        return _storage.setDouble(key, value).then((bool success) => success);
      case String:
        return _storage.setString(key, value).then((bool success) => success);
      case List<String>:
        return _storage.setStringList(key, value).then((bool success) => success);
      case bool:
        return _storage.setBool(key, value).then((bool success) => success);
      default:
        return _storage.setString(key, value.toString()).then((bool success) => success);
    }
  }
}
