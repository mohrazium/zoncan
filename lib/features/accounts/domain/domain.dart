library zoncan.features.account.domain;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';

import '../data/data.dart';

part 'entity/user_details_entity.dart';
part 'repository/user_details_repository.dart';
part 'usecases/user_findby_email_usecase.dart';
part 'usecases/user_findby_username_usecase.dart';
part 'usecases/user_findby_uuid_usecase.dart';
part 'usecases/user_exist_usecase.dart';

part 'domain.mapper.dart';
part 'entity/person_entity.dart';
part 'entity/accounting_info_entity.dart';
part 'entity/address_entity.dart';
part 'enums/person_type.dart';
part 'enums/balance_type.dart';
part 'enums/begging_of_balance_type.dart';