library zoncan.features.account.domain;

import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/core.dart';
import 'package:zoncan/features/persons/accounts.dart';

import '../domain/domain.dart';

part 'models/person_model.dart';

part 'models/accounting_info_model.dart';

part 'models/address_model.dart';

// part 'repository/person_repository_impl.dart';
part 'datasource/local/person_table.dart';

part 'datasource/local/accounting_info_table.dart';

part 'datasource/local/address_table.dart';

part 'models/models_types.dart';

part 'data.g.dart';

part 'data.mapper.dart';
