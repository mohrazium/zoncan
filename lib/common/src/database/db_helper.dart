import 'generated/generated.dart';

class DbHelper {
  /// The Store of this app.
  late final Store store;

  DbHelper._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<DbHelper> create() async {
    final store = await openStore(directory: "/home/mohrazium/Documents/zoncan/data/");
    return DbHelper._create(store);
  }
}
