part of '../../../security.dart';
@Injectable()
class UsernameAlreadyExistsUsecase extends Usecase<bool, String> {
  final AuthenticationRepository _repository;

  UsernameAlreadyExistsUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async {
    try {
      return await _repository
          .usernameAlreadyExists(params)
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
