part of '../../../security.dart';

@Injectable()
class RememberedPasswordUsecase extends Usecase<String?, String?> {
  final AuthenticationRepository _repository;

  RememberedPasswordUsecase(this._repository);

  @override
  Future<Either<FailureException, String?>> call({String? params}) async =>
      await _repository.rememberedPassword.then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
