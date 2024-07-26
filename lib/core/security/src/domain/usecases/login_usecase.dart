part of '../../../security.dart';

typedef LoginParams = ({String username, String password, bool? rememberMe});
@Injectable()
class LoginUsecase extends Usecase<UserDetailsModel?, LoginParams> {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
      {required LoginParams params}) async {
    try {
      return await _repository
          .login(params.username, params.password, params.rememberMe ?? false)
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
