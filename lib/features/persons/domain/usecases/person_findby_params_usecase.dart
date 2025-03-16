// part of '../domain.dart';
// @Injectable()
// class UserFindByUsernameUsecase extends Usecase<UserDetailsModel, String> {
//   final PersonRepository _repository;
//
//   UserFindByUsernameUsecase(this._repository);
//
//   @override
//   Future<Either<FailureException, UserDetailsModel>> call(
//       {required String params}) async {
//     try {
//       return await _repository
//           .findUserByUsername(params)
//           .then((foundedUser) => Either.right(foundedUser!));
//     } on FailureException catch (e) {
//       return Either.left(e);
//     }
//   }
// }
