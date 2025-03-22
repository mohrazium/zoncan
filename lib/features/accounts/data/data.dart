library zoncan.features.account.domain;

import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/accounts/accounts.dart';
import 'package:zoncan/features/features.dart';

import '../domain/domain.dart';

part 'models/user_details_model.dart';
part 'repository/user_details_repository_impl.dart';
part 'datasource/local/tables/user_details_table.dart';
part 'datasource/local/daos/user_details_dao.dart';
part 'models/person_model.dart';

part 'models/accounting_info_model.dart';

part 'models/address_model.dart';

part 'datasource/local/tables/person_table.dart';
part 'datasource/local/daos/person_dao.dart';

part 'datasource/local/tables/accounting_info_table.dart';

part 'datasource/local/tables/address_table.dart';

part 'data.g.dart';
part 'data.mapper.dart';
