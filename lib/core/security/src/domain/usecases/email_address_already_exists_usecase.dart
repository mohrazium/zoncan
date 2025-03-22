part of '../../../security.dart';

@Injectable()
class EmailAddressAlreadyExistsUsecase extends Usecase<bool, String> {
  final AuthenticationRepository _repository;

  EmailAddressAlreadyExistsUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async =>
      await _repository.emailAddressAlreadyExists(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
