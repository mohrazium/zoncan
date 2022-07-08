import 'package:objectbox/objectbox.dart';

abstract class StoreRepository<I, T> {
  Future<Box<T>> get storeBox;
  Future<T> save(T table);
  Future<List<I>> saveAll(List<T> tables);
  Future<void> saveQueued(T table);
  Future<T?> findById(I id);
  Future<List<T?>> findByIds(List<I> ids);
  Future<List<T?>> findAll();
  Future<bool> update(T table);
  Future<bool> delete(T table);
  Future<int> deleteAll();
}
