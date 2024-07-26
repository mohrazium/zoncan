part of '../../../security.dart';
@Injectable()
class LogoutUsecase extends Usecase<bool?, String?> {
  final AuthenticationRepository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<FailureException, bool?>> call({String? params}) async {
    try {
      return await _repository
          .logout()
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
