part of '../../../security.dart';

typedef LoginParams = ({String username, String password, bool? rememberMe});

@Injectable()
class LoginUsecase extends Usecase<UserDetailsModel?, LoginParams> {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {required LoginParams params}) async =>
      await _repository
          .login(params.username, params.password, params.rememberMe ?? false)
          .then((res) =>
              res.match((failure) => Left(failure), (result) => Right(result)));
}
