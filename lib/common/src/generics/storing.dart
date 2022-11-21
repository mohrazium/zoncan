part of common.generics;

abstract class Storing<I, T> {
  Future<Box<T>> get storeBox;
  Future<I?> save(T table);
  Future<List<I>> saveAll(List<T> tables);
  Future<I> saveQueued(T table);
  Future<T?> findById(I id);
  Future<List<T?>> findByIds(List<I> ids);
  Future<List<T?>> findAll();
  Future<bool> update(T table);
  Future<bool> delete(T table);
  Future<int> deleteAll();
}
