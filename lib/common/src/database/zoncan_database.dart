import 'generated/generated.dart';

class ZoncanDatabase {
  /// The Store of this app.
  late final Store store;

  ZoncanDatabase._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ZoncanDatabase> create() async {
    final store = await openStore(directory: "/home/mohrazium/Documents/zoncan/data/");
    return ZoncanDatabase._create(store);
  }
}
