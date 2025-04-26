
import 'dart:core';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

@Injectable()
class RememberedUsernameUsecase extends Usecase<String?, String?> {
  final AuthenticationRepository _repository;

  RememberedUsernameUsecase(this._repository);

  @override
  Future<Either<FailureException, String?>> call({String? params}) async =>
      await _repository.rememberedUsername;
}
