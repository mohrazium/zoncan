part of '../../../security.dart';

typedef SignupParams = ({UserDetailsModel user, String password});

@Injectable()
class SignUpUsecase extends Usecase<UserDetailsModel?, SignupParams> {
  final AuthenticationRepository _repository;

  SignUpUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {required SignupParams params}) async =>
      await _repository.signup(params.user, params.password).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
