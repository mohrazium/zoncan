part of '../domain.dart';

abstract class UserDetailsRepository {
  Future<Either<FailureException, UserDetailsModel>> saveUser(
      UserDetailsModel user);
  Future<Either<FailureException, UserDetailsModel>> findUserByUUID(
      String uuid);
  Future<Either<FailureException, UserDetailsModel>> findUserByEmail(
      String email);
  Future<Either<FailureException, UserDetailsModel>> findUserByUsername(
      String username);
  Future<Either<FailureException, bool>> userExist(String usernameOrEmail);
  Future<Either<FailureException, bool>> deleteUser(UserDetailsModel entity);
  Future<Either<FailureException, UserDetailsModel>> updateUser(
      UserDetailsModel entity);
  Future<Either<FailureException, bool>> deleteUserByUUID(String uuid);
  Future<Either<FailureException, List<UserDetailsModel>>> findAllUsers();
}
