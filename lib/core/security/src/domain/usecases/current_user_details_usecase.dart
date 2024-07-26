part of '../../../security.dart';
@Injectable()
class CurrentUserDetailsUsecase extends Usecase<UserDetailsModel?, String?> {
  final AuthenticationRepository _repository;

  CurrentUserDetailsUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call({String? params}) async {
    try {
      return await _repository
          .currentUserDetails()
          .then((resultValue) => Either.right(resultValue));
    } on FailureException catch (e) {
      return Either.left(e);
    }
  }
}
