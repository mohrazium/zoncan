part of '../../../security.dart';

@Injectable()
class CurrentUserDetailsUsecase extends Usecase<UserDetailsModel?, String?> {
  final AuthenticationRepository _repository;

  CurrentUserDetailsUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {String? params}) async =>
      await _repository.currentUserDetails().then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
