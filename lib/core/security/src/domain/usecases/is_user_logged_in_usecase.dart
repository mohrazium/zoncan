part of '../../../security.dart';

@Injectable()
class IsUserLoggedInUsecase extends Usecase<bool, String?> {
  final AuthenticationRepository _repository;

  IsUserLoggedInUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({String? params}) async =>
      await _repository.isUserLoggedIn().then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
