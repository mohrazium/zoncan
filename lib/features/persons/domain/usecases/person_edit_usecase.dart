// part of '../domain.dart';
// @Injectable()
// class UserFindByUUIDUsecase extends Usecase<UserDetailsModel, String> {
//   final PersonRepository _repository;
//
//   UserFindByUUIDUsecase(this._repository);
//
//   @override
//   Future<Either<FailureException, UserDetailsModel>> call(
//       {required String params}) async {
//     try {
//       return await _repository
//           .findUserByUUID(params)
//           .then((foundedUser) => Either.right(foundedUser!));
//     } on FailureException catch (e) {
//       return Either.left(e);
//     }
//   }
// }
//
