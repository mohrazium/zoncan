part of '../domain.dart';

@Injectable()
class UserFindByUsernameUsecase extends Usecase<UserDetailsModel, String> {
  final UserDetailsRepository _repository;

  UserFindByUsernameUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel>> call(
          {required String params}) async =>
      await _repository.findUserByUsername(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
