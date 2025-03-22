part of '../domain.dart';

@Injectable()
class UserFindByEmailUsecase extends Usecase<UserDetailsModel, String> {
  final UserDetailsRepository _repository;

  UserFindByEmailUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel>> call(
          {required String params}) async =>
      await _repository.findUserByEmail(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
