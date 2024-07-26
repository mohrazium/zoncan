part of 'database.dart';

late final _ZoncanDatabase _zoncanDatabase;

// @Injectable()
// class ZoncanDatabase {
//   /// The Store of this app.
//   final Store store;
//
//   @FactoryMethod(preResolve: true)
//   ZoncanDatabase.create(this.store) {
//     //
//   }
//
//   /// Create an instance of ObjectBox to use throughout the app.
//   @FactoryMethod(preResolve: true)
//   Future<ZoncanDatabase> create() async {
//     final path = Directory(_dbPath);
//     if (!await path.exists()) {
//       path.create();
//     }
//
//     final objectBoxStore = await openStore(directory: _dbPath);
//     return ZoncanDatabase.create(objectBoxStore);
//   }
// }
class _ZoncanDatabase {
  static const _dbPath = "/home/mohrazium/Documents/zoncan";

  /// The Store of this app.
  late final Store objectBoxStore;

  _ZoncanDatabase();

  _ZoncanDatabase._create(this.objectBoxStore) {
    //
  }

  Future<void> initialize() async {
    _zoncanDatabase = await this.create();
  }

  Future<_ZoncanDatabase> create() async {
    // Future<store> openStore() {...} is defined in the generated objectbox.g.dart
    final path = Directory(_dbPath);
    if (!await path.exists()) {
      path.create();
    }

    objectBoxStore = await openStore(directory: _dbPath);
    return _ZoncanDatabase._create(objectBoxStore);
  }
}

@LazySingleton()
class ZoncanDatabase {
  Future<_ZoncanDatabase> get zoncanObjectBoxDB async => _zoncanDatabase;

  Future<void> initialize() async {
    await _ZoncanDatabase().initialize();
  }

  dispose() {
    if (!_zoncanDatabase.objectBoxStore.isClosed()) {
      _zoncanDatabase.objectBoxStore.close();
    }
  }
}
