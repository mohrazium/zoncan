part of '../domain.dart';
@Injectable()
class UserFindByEmailUsecase extends Usecase<UserDetailsModel, String> {
  final UserDetailsRepository _repository;

  UserFindByEmailUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel>> call(
      {required String params}) async {
    try {
      return await _repository
          .findUserByEmail(params)
          .then((foundedUser) => Either.right(foundedUser!));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}

