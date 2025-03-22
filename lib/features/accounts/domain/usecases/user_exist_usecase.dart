part of '../domain.dart';

@Injectable()
class UserExistUsecase extends Usecase<bool, String> {
  final UserDetailsRepository _repository;

  UserExistUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async =>
      await _repository.userExist(params).then((res) =>
          res.match((failure) => Left(failure), (result) => Right(result)));
}
