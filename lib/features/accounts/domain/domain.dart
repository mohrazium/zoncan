library zoncan.features.account.domain;

import 'package:built_value/built_value.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/persons/domain/domain.dart';

import '../data/data.dart';

part 'entity/user_details_entity.dart';
part 'repository/user_details_repository.dart';
part 'usecases/user_findby_email_usecase.dart';
part 'usecases/user_findby_username_usecase.dart';
part 'usecases/user_findby_uuid_usecase.dart';
part 'usecases/user_not_exist_usecase.dart';