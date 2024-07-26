part of '../../../security.dart';
@Injectable()
class RememberedUsernameUsecase extends Usecase<String?, String?> {
  final AuthenticationRepository _repository;

  RememberedUsernameUsecase(this._repository);

  @override
  Future<Either<FailureException, String?>> call({String? params}) async {
    try {
      return await _repository.rememberedUsername
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
