part of '../../../security.dart';

abstract class AuthenticationRepository {
 Future<Either<FailureException,bool>> isUserLoggedIn();
  Future<Either<FailureException,bool>> usernameAlreadyExists(String username);
  Future<Either<FailureException,bool>> emailAddressAlreadyExists(String email);
 Future<Either<FailureException,UserDetailsModel>> signup(UserDetailsModel user, String password);
  Future<Either<FailureException,UserDetailsModel>> login(String username, String password,
      [bool rememberMe = false]);
  Future<Either<FailureException,bool>> logout();
  Future<Either<FailureException,UserDetailsModel>> currentUserDetails();
 Future<Either<FailureException,String>> get rememberedUsername;
  Future<Either<FailureException,String>> get rememberedPassword;
}