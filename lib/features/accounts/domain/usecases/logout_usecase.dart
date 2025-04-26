
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

@Injectable()
class LogoutUsecase extends Usecase<bool?, String?> {
  final AuthenticationRepository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<FailureException, bool?>> call({String? params}) async =>
      await _repository.logout();
}
