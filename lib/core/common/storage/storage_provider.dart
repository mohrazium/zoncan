import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageProvider {
  Future<bool> write(String key, dynamic value);

  Future<dynamic> read(String key);

  Future<bool> delete(String key);
}

@Injectable(as: StorageProvider)
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
      case const (int):
        return _storage.getInt(key);
      case const (double):
        return _storage.getDouble(key);
      case const (String):
        return _storage.getString(key);
      case const (List<String>):
        return _storage.getStringList(key);
      case const (bool):
        return _storage.getBool(key);
      default:
        return _storage.getString(key);
    }
  }

  @override
  Future<bool> write(String key, dynamic value) async {
    _storage = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case const (int):
        return _storage.setInt(key, value).then((bool success) => success);
      case const (double):
        return _storage.setDouble(key, value).then((bool success) => success);
      case const (String):
        return _storage.setString(key, value).then((bool success) => success);
      case const (List<String>):
        return _storage
            .setStringList(key, value)
            .then((bool success) => success);
      case const (bool):
        return _storage.setBool(key, value).then((bool success) => success);
      default:
        return _storage
            .setString(key, value.toString())
            .then((bool success) => success);
    }
  }
}
