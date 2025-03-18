library zoncan.features.account.domain;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/data/data.dart';
import 'package:zoncan/features/accounts/domain/domain.dart';
import 'package:zoncan/features/persons/data/data.dart';

import '../../accounts/accounts.dart';


part 'domain.mapper.dart';
part 'entity/person_entity.dart';
part 'entity/accounting_info_entity.dart';
part 'entity/address_entity.dart';
part 'enums/person_type.dart';
part 'enums/balance_type.dart';
part 'enums/begging_of_balance_type.dart';
part 'repository/person_repository.dart';
part 'usecases/person_save_usecase.dart';
part 'usecases/person_findby_params_usecase.dart';
part 'usecases/person_edit_usecase.dart';
part 'usecases/person_delete_usecase.dart';