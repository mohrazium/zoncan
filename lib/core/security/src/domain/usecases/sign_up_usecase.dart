part of '../../../security.dart';

typedef SignupParams = ({UserDetailsModel user, String password});
@Injectable()
class SignUpUsecase extends Usecase<UserDetailsModel?, SignupParams> {
  final AuthenticationRepository _repository;

  SignUpUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
      {required SignupParams params}) async {
    try {
      return await _repository
          .signup(params.user, params.password)
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
