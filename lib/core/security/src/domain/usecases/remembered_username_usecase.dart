part of '../../../security.dart';

@Injectable()
class RememberedUsernameUsecase extends Usecase<String?, String?> {
  final AuthenticationRepository _repository;

  RememberedUsernameUsecase(this._repository);

  @override
  Future<Either<FailureException, String?>> call({String? params}) async =>
      await _repository.rememberedUsername.then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
