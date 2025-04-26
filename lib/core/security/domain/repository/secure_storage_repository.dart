
import 'dart:core';

import 'package:zoncan/core/core.dart';

abstract class SecureStorageRepository {
  bool isData = false;
  void initial(String secretKey);
  Future<bool> write(SecurityKeys key, dynamic value);
  Future<dynamic> read(SecurityKeys key, [String? password]);
  Future<bool> delete(SecurityKeys key);
}
