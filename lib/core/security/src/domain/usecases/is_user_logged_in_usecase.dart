part of '../../../security.dart';
@Injectable()
class IsUserLoggedInUsecase extends Usecase<bool, String?> {
  final AuthenticationRepository _repository;

  IsUserLoggedInUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({String? params}) async {
    try {
      return await _repository
          .isUserLoggedIn()
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
