
import 'package:fpdart/fpdart.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'package:zoncan/features/accounts/data/models/user_details_model.dart';


abstract class UserDetailsRepository {
  Future<Either<FailureException, UserDetailsModel>> saveUser(
    UserDetailsModel user,
  );
  Future<Either<FailureException, UserDetailsModel>> findUser(String uuid);
  Future<Either<FailureException, UserDetailsModel>> findUserByEmail(
    String email,
  );
  Future<Either<FailureException, UserDetailsModel>> findUserByUsername(
    String username,
  );
  Future<Either<FailureException, bool>> userExist(String usernameOrEmail);
  Future<Either<FailureException, bool>> removeUser(UserDetailsModel entity);
  Future<Either<FailureException, UserDetailsModel>> updateUser(
    UserDetailsModel entity,
  );
  Future<Either<FailureException, List<UserDetailsModel>>> findAllUsers();
}
