import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/common/common.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';

import '../../data/models/user_details_model.dart';
import '../repository/user_details_repository.dart';

@Injectable()
class UserFindByUsernameUsecase extends Usecase<UserDetailsModel, String> {
  final UserDetailsRepository _repository;

  UserFindByUsernameUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel>> call(
          {required String params}) async =>
      await _repository.findUserByUsername(params);
}
