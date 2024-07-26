library zoncan.core.common.database;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zoncan/app/app.dart';
import 'package:zoncan/config/config.dart';
import 'package:zoncan/core/exceptions/exceptions.dart';
import 'generated/objectbox.g.dart';

export 'generated/objectbox.g.dart'
    hide Entity, Id, Property, PropertyType, Unique, Store;

import '../generics/generics.dart';

part 'auditor/audit_table.dart';

part 'auditor/auditor.dart';

part 'zoncan_database.dart';

part 'database.g.dart';

// part 'auditor/auditor.dart';
// part 'auditor/audit_table.dart.dart';
// part 'generated/generated.dart';
// part 'zoncan_database.dart';
// part 'database.g.dart';
