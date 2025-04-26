
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

import '../../data/models/user_details_model.dart';

@Injectable()
class CurrentUserDetailsUsecase extends Usecase<UserDetailsModel?, String?> {
  final AuthenticationRepository _repository;

  CurrentUserDetailsUsecase(this._repository);

  @override
  Future<Either<FailureException, UserDetailsModel?>> call(
          {String? params}) async =>
      await _repository.currentUserDetails();
}
