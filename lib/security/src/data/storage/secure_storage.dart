import 'dart:io';

import 'package:cryptology/cryptology.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SecureStorage {
  void initial(String secretKey, bool isData);
  Future<bool> write(dynamic value);
  Future<dynamic> read([String? password]);
  Future<bool> delete();
}

class SecureStorageImpl extends SecureStorage {
  late final bool _isData;
  late final String _secretKey;
  late final PasswordEncryption _passwordEncryption;
  late final DataEncryption _dataEncryption;
  @override
  void initial(String secretKey, bool isData) {
    _secretKey = secretKey;
    _isData = isData;
    _passwordEncryption = PasswordEncryption.initial(secretKey: _secretKey);
    _dataEncryption = DataEncryption.initial(secretKey: _secretKey);
  }

  late SharedPreferences _storage;
  @override
  Future<bool> delete() async {
    _storage = await SharedPreferences.getInstance();
    return _storage.remove(_secretKey).then((bool success) => success);
  }

  @override
  Future<dynamic> read([String? password]) async {
    _storage = await SharedPreferences.getInstance();
    String? storedValue = _storage.getString(_secretKey);
    if (storedValue != null) {
      if (_isData) {
        if (storedValue.contains("file:")) {
          storedValue = storedValue.replaceAll("file:", "");
          final data = await _dataEncryption.decryptB64(storedValue);
          return File.fromRawPath(data);
        } else {
          return CryptoHelpers.toUtf8(
              await _dataEncryption.decryptB64(storedValue));
        }
      } else {
        return _passwordEncryption.verifyB64(password!, storedValue);
      }
    }
  }

  @override
  Future<bool> write(dynamic value) async {
    _storage = await SharedPreferences.getInstance();
    late final String encodedData;
    if (_isData) {
      if (value is String) {
        encodedData = await _dataEncryption.encryptB64(value.toBytes());
      } else if (value is File) {
        encodedData =
            "file:${await _dataEncryption.encryptB64(await value.readAsBytes())}";
      } else {
        throw "${value.runtimeType} type is not supported";
      }
    } else {
      encodedData = await _passwordEncryption.hashB64(value.toString());
    }
    return _storage
        .setString(_secretKey, encodedData)
        .then((bool success) => success);
  }
}
