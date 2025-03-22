library zoncan.core.common.database;

import 'dart:io';

import 'package:injectable/injectable.dart';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../features/features.dart';
import 'helper/drift_serializer.dart';

part 'auditor/audit_table.dart';

part 'auditor/auditor_dao.dart';
part 'helper/zoncan_database.dart';
part 'database.g.dart';

// part 'auditor/auditor.dart';
// part 'auditor/audit_table.dart.dart';
// part 'generated/generated.dart';
// part 'zoncan_database.dart';
// part 'database.g.dart';
