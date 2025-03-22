part of '../../../security.dart';

@Injectable()
class LogoutUsecase extends Usecase<bool?, String?> {
  final AuthenticationRepository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<FailureException, bool?>> call({String? params}) async =>
      await _repository.logout().then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
