
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

import '../../data/models/user_details_model.dart';

typedef LoginParams = ({String username, String password, bool? rememberMe});

@Injectable()
class LoginUsecase extends Usecase<UserDetailsModel?, LoginParams> {
  final AuthenticationRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {required LoginParams params}) async =>
      await _repository
          .login(params.username, params.password, params.rememberMe ?? false);
}
