part of 'generics.dart';

abstract class Storing<I, T> {
  @protected
  Future<Box<T>> get storeBox;
  @protected
  Future<I?> save(T table);
  @protected
  Future<List<I>> saveAll(List<T> tables);
  @protected
  Future<I> saveQueued(T table);
  @protected
  Future<T?> findById(I id);
  @protected
  Future<List<T?>> findByIds(List<I> ids);
  @protected
  Future<List<T?>> findAll();
  @protected
  Future<bool> update(T table);
  @protected
  Future<bool> delete(T table);
  @protected
  Future<int> deleteAll();
}
