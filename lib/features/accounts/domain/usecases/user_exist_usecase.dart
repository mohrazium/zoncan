
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

import '../repository/user_details_repository.dart';

@Injectable()
class UserExistUsecase extends Usecase<bool, String> {
  final UserDetailsRepository _repository;

  UserExistUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async =>
      await _repository.userExist(params);
}
