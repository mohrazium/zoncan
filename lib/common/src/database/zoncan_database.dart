import 'dart:io';

import 'generated/generated.dart';

class ZoncanDatabase {
  /// The Store of this app.
  late final Store store;

  ZoncanDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ZoncanDatabase> create() async {
    const dbPath = "/home/mohrazium/Documents/zoncan";
    final path = Directory(dbPath);
    if (!await path.exists()) {
      path.create();
    }

    final store = await openStore(directory: dbPath);
    return ZoncanDatabase._create(store);
  }
}
