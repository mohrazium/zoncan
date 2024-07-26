part of '../../../security.dart';

abstract class AuthenticationRepository {
  Future<bool> isUserLoggedIn();
  Future<bool> usernameAlreadyExists(String username);
  Future<bool> emailAddressAlreadyExists(String email);
  Future<UserDetailsModel?> signup(UserDetailsModel user, String password);
  Future<UserDetailsModel?> login(String username, String password,
      [bool rememberMe = false]);
  Future<bool?> logout();
  Future<UserDetailsModel?> currentUserDetails();
  Future<String?> get rememberedUsername;
  Future<String?> get rememberedPassword;
}