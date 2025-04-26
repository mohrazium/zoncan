
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

import '../../data/models/user_details_model.dart';

typedef SignupParams = ({UserDetailsModel user, String password});

@Injectable()
class SignUpUsecase extends Usecase<UserDetailsModel?, SignupParams> {
  final AuthenticationRepository _repository;

  SignUpUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {required SignupParams params}) async =>
      await _repository.signup(params.user, params.password);
}
