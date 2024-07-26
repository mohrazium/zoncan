part of '../../../security.dart';
@Injectable()
class RememberedPasswordUsecase extends Usecase<String?, String?> {
  final AuthenticationRepository _repository;

  RememberedPasswordUsecase(this._repository);

  @override
  Future<Either<FailureException, String?>> call({ String? params}) async {
    try {
      return await _repository
          .rememberedPassword
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
