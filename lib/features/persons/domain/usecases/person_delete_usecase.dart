part of '../domain.dart';
@Injectable()
class UserNotExistUsecase extends Usecase<bool, String> {
  final UserDetailsRepository _repository;

  UserNotExistUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async {
    try {
      return await _repository.findUserByUsername(params).then((foundedUser) =>
          foundedUser == null ? Either.right(true) : Either.right(false));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
