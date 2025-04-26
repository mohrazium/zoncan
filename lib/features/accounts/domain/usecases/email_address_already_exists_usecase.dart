
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

@Injectable()
class EmailAddressAlreadyExistsUsecase extends Usecase<bool, String> {
  final AuthenticationRepository _repository;

  EmailAddressAlreadyExistsUsecase(this._repository);

  @override
  Future<Either<FailureException, bool>> call({required String params}) async =>
      await _repository.emailAddressAlreadyExists(params);
}
