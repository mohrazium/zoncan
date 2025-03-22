part of '../domain.dart';

@Injectable()
class UserFindByUUIDUsecase extends Usecase<UserDetailsModel, String> {
  final UserDetailsRepository _repository;

  UserFindByUUIDUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel>> call(
          {required String params}) async =>
      await _repository.findUserByUUID(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
