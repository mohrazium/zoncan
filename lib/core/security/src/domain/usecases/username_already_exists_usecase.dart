part of '../../../security.dart';

@Injectable()
class UsernameAlreadyExistsUsecase extends Usecase<bool, String> {
  final AuthenticationRepository _repository;

  UsernameAlreadyExistsUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async =>
      await _repository.usernameAlreadyExists(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
