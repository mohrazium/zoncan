part of '../../../security.dart';
@Injectable()
class EmailAddressAlreadyExistsUsecase extends Usecase<bool, String> {
  final AuthenticationRepository _repository;

  EmailAddressAlreadyExistsUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async {
    try {
      return await _repository
          .emailAddressAlreadyExists(params)
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
