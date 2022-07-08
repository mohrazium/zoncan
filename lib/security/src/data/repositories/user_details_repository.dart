import 'package:flutter_modular/flutter_modular.dart';
import 'package:objectbox/src/native/box.dart';
import 'package:zoncan/common/common.dart' show StoreRepository, ZoncanDatabase;
import 'package:zoncan/exceptions/exceptions.dart';

import '../datasources/datasources.dart' show UserDetailsTable;

abstract class UserDetailsRepository
    extends StoreRepository<int, UserDetailsTable> {}

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  @override
  Future<Box<UserDetailsTable>> get storeBox async =>
      await Modular.getAsync<ZoncanDatabase>()
          .then((db) => db.store.box<UserDetailsTable>())
          .onError((error, stackTrace) => throw FailureException(
                "Can't create user details box in user details repository.",
                error,
                stackTrace,
              ));

  @override
  Future<bool> delete(UserDetailsTable table) async {
    return await storeBox
        .then((box) {
          if (table.id != 0) {
            if (box.get(table.id) != null) {
              return box;
            } else {
              throw FailureException("User not found by id : ${table.id}");
            }
          } else {
            throw FailureException("Not valid user details.");
          }
        })
        .then((validBox) => validBox.remove(table.id))
        .onError((error, stackTrace) => throw FailureException(
              "Can't delete user.",
              error,
              stackTrace,
            ));
  }

  @override
  Future<int> deleteAll() async {
    return await storeBox
        .then((box) => box.removeAll())
        .onError((error, stackTrace) => throw FailureException(
              "Can't delete all users.",
              error,
              stackTrace,
            ));
  }

  @override
  Future<List<UserDetailsTable?>> findAll() async {
    return await storeBox
        .then((box) => box.getAll())
        .onError((error, stackTrace) => throw FailureException(
              "Can't find all users.",
              error,
              stackTrace,
            ));
  }

  @override
  Future<UserDetailsTable?> findById(int id) async {
    return await storeBox
        .then((box) => box.get(id))
        .onError((error, stackTrace) => throw FailureException(
              "Can't find user by id $id",
              error,
              stackTrace,
            ));
  }

  @override
  Future<List<UserDetailsTable?>> findByIds(List<int> ids) async {
    return await storeBox
        .then((box) => box.getMany(ids))
        .onError((error, stackTrace) => throw FailureException(
              "Can't find users by this id's $ids",
              error,
              stackTrace,
            ));
  }

  @override
  Future<UserDetailsTable> save(UserDetailsTable table) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<List<int>> saveAll(List<UserDetailsTable> tables) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }

  @override
  Future<void> saveQueued(UserDetailsTable table) {
    // TODO: implement saveQueued
    throw UnimplementedError();
  }

  @override
  Future<bool> update(UserDetailsTable table) {
    // TODO: implement update
    throw UnimplementedError();
  }
  // For api integration declare ds here
  // like: final UserDetailsClient _client;
}
